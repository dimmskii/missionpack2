cmake_minimum_required(VERSION 3.18)
project(missionpack2_qvm NONE)

# bin/windows/*.exe is the original QIIIA SDK toolchain (Win32-only).
# bin/linux/* are native x86-64 ELF builds of the same q3lcc/q3asm
# (from ec-/baseq3a, build/linux-qvm/tools/) - run those directly on
# Linux hosts, no Wine/compat layer required. Pick the right set by
# host platform; both run the same way otherwise.
if(WIN32)
  set(Q3_BIN_DIR "${CMAKE_CURRENT_SOURCE_DIR}/bin/windows")
  set(Q3LCC "${Q3_BIN_DIR}/q3lcc.exe")
  set(Q3ASM "${Q3_BIN_DIR}/q3asm.exe")
else()
  set(Q3_BIN_DIR "${CMAKE_CURRENT_SOURCE_DIR}/bin/linux")
  set(Q3LCC "${Q3_BIN_DIR}/q3lcc")
  set(Q3ASM "${Q3_BIN_DIR}/q3asm")
endif()

set(Q3_INCLUDE_FLAGS
  "-I${CMAKE_CURRENT_SOURCE_DIR}/code/cgame"
  "-I${CMAKE_CURRENT_SOURCE_DIR}/code/game"
  "-I${CMAKE_CURRENT_SOURCE_DIR}/code/ui"
  "-I${CMAKE_CURRENT_SOURCE_DIR}/code/common"
)

# Mirrors the %1 (-DDEBUG) argument debug.bat passes to every module bat.
option(Q3_DEBUG_VM "Compile QVM modules with -DDEBUG, like debug.bat" OFF)
if(Q3_DEBUG_VM)
  set(Q3_DEBUG_FLAG "-DDEBUG")
else()
  set(Q3_DEBUG_FLAG "")
endif()

set(Q3_VERSION "061" CACHE STRING "Mod version digits, matches release.bat's VERSION")

add_subdirectory(code/game)
add_subdirectory(code/cgame)
add_subdirectory(code/ui)

add_custom_target(vm ALL DEPENDS qagame cgame ui)

# Always-debug build (-DDEBUG unconditional, like debug.bat itself did -
# independent of the Q3_DEBUG_VM option above, which only affects the
# regular `vm` target). Not part of ALL; build explicitly when needed.
add_custom_target(vm_debug DEPENDS qagame_debug cgame_debug ui_debug)

# --- release: replicates release.bat (stage vm+ui+assets, zip to .pk3,
# drop at gamedir root) ---
set(MOD_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/..")
set(RELEASE_STAGE "${CMAKE_CURRENT_BINARY_DIR}/_release_stage")
string(SUBSTRING "${Q3_VERSION}" 0 1 Q3_VERSION_MAJOR)
string(SUBSTRING "${Q3_VERSION}" 1 -1 Q3_VERSION_MINOR)

# release.bat writes description.txt with no trailing newline (`set /p`);
# file(WRITE) matches that exactly, unlike `cmake -E echo`.
add_custom_target(write_description
  COMMAND ${CMAKE_COMMAND}
          "-DDESC_FILE=${MOD_ROOT}/description.txt"
          "-DDESC_TEXT=Quake III Ultimate Arena ${Q3_VERSION_MAJOR}.${Q3_VERSION_MINOR}"
          -P "${CMAKE_CURRENT_SOURCE_DIR}/cmake/WriteDescription.cmake"
  COMMENT "Writing description.txt"
  VERBATIM
)

add_custom_target(release
  COMMAND ${CMAKE_COMMAND} -E remove_directory "${RELEASE_STAGE}"
  COMMAND ${CMAKE_COMMAND} -E make_directory "${RELEASE_STAGE}/vm"
  COMMAND ${CMAKE_COMMAND} -E copy
          "${CMAKE_CURRENT_SOURCE_DIR}/code/game/vm/qagame.qvm"
          "${CMAKE_CURRENT_SOURCE_DIR}/code/cgame/vm/cgame.qvm"
          "${CMAKE_CURRENT_SOURCE_DIR}/code/ui/vm/ui.qvm"
          "${RELEASE_STAGE}/vm/"
  COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_CURRENT_SOURCE_DIR}/ui" "${RELEASE_STAGE}/ui"
  COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_CURRENT_SOURCE_DIR}/assets" "${RELEASE_STAGE}"
  COMMAND ${CMAKE_COMMAND} -E chdir "${RELEASE_STAGE}" ${CMAKE_COMMAND} -E tar cf "${MOD_ROOT}/pak${Q3_VERSION}.pk3" --format=zip -- .
  DEPENDS vm write_description
  COMMENT "Packaging pak${Q3_VERSION}.pk3 at gamedir root (release.bat equivalent)"
  VERBATIM
)

# --- release_aux: replicates release.bat's PK3_AUX section (the part
# it skips via "::GOTO PK3_AUX" instead of "GOTO PK3_AUX"). Zips each
# pk3/<name>/ content directory into <name>.pk3 at the gamedir root.
# Independent of the vm build - these are pure content pk3s. ---
file(GLOB PK3_AUX_DIRS LIST_DIRECTORIES true "${CMAKE_CURRENT_SOURCE_DIR}/pk3/*")
add_custom_target(release_aux
  COMMENT "Packaging auxiliary content pk3s at gamedir root (release.bat PK3_AUX equivalent)"
)
foreach(aux_dir ${PK3_AUX_DIRS})
  if(IS_DIRECTORY "${aux_dir}")
    get_filename_component(aux_name "${aux_dir}" NAME)
    add_custom_command(
      TARGET release_aux POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E chdir "${aux_dir}" ${CMAKE_COMMAND} -E tar cf "${MOD_ROOT}/${aux_name}.pk3" --format=zip -- .
      COMMENT "Packaging ${aux_name}.pk3"
      VERBATIM
    )
  endif()
endforeach()

# --- debug: replicates debug.bat's loose-file deploy (no .pk3, no
# launching the engine - that part is host/GUI specific). Always uses
# the -DDEBUG build (vm_debug), matching debug.bat's unconditional flag. ---
add_custom_target(debug_deploy
  COMMAND ${CMAKE_COMMAND} -E make_directory "${MOD_ROOT}/vm"
  COMMAND ${CMAKE_COMMAND} -E copy
          "${CMAKE_CURRENT_SOURCE_DIR}/code/game/vm/debug/qagame.qvm"
          "${MOD_ROOT}/vm/qagame.qvm"
  COMMAND ${CMAKE_COMMAND} -E copy
          "${CMAKE_CURRENT_SOURCE_DIR}/code/cgame/vm/debug/cgame.qvm"
          "${MOD_ROOT}/vm/cgame.qvm"
  COMMAND ${CMAKE_COMMAND} -E copy
          "${CMAKE_CURRENT_SOURCE_DIR}/code/ui/vm/debug/ui.qvm"
          "${MOD_ROOT}/vm/ui.qvm"
  COMMAND ${CMAKE_COMMAND} -E rm -rf "${MOD_ROOT}/ui"
  COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_CURRENT_SOURCE_DIR}/ui" "${MOD_ROOT}/ui"
  DEPENDS vm_debug
  COMMENT "Deploying loose -DDEBUG vm/ + ui/ to gamedir root (debug.bat equivalent, minus launching the engine)"
  VERBATIM
)
