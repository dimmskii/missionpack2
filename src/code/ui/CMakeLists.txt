# Translates ui.bat: compiles each listed .c (drawn from both code/ui
# and shared code/game files) to bytecode .asm via q3lcc, then links
# them per ui.q3asm via q3asm into ui.qvm.

set(UI_VM_DIR "${CMAKE_CURRENT_SOURCE_DIR}/vm")
file(MAKE_DIRECTORY "${UI_VM_DIR}")
set(GAME_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../game")

set(UI_SOURCES
  ui_main.c
  "${GAME_DIR}/bg_misc.c"
  "${GAME_DIR}/bg_newgame.c"
  "${GAME_DIR}/bg_lib.c"
  "${GAME_DIR}/q_math.c"
  "${GAME_DIR}/q_shared.c"
  ui_atoms.c
  ui_players.c
  ui_util.c
  ui_shared.c
  ui_gameinfo.c
)

set(UI_ASM_FILES "")
foreach(src ${UI_SOURCES})
  get_filename_component(name "${src}" NAME_WE)
  if(IS_ABSOLUTE "${src}")
    set(src_path "${src}")
  else()
    set(src_path "${CMAKE_CURRENT_SOURCE_DIR}/${src}")
  endif()
  set(asm_out "${UI_VM_DIR}/${name}.asm")
  add_custom_command(
    OUTPUT "${asm_out}"
    COMMAND "${Q3LCC}" -DQ3_VM ${Q3_DEBUG_FLAG}
            -S -Wf-target=bytecode -Wf-g ${Q3_INCLUDE_FLAGS}
            "${src_path}"
    WORKING_DIRECTORY "${UI_VM_DIR}"
    DEPENDS "${src_path}"
    COMMENT "q3lcc ui/${name}.c"
    VERBATIM
  )
  list(APPEND UI_ASM_FILES "${asm_out}")
endforeach()

add_custom_command(
  OUTPUT "${UI_VM_DIR}/ui.qvm"
  COMMAND "${Q3ASM}" -vq3 -r -m -v -f "${CMAKE_CURRENT_SOURCE_DIR}/ui"
  WORKING_DIRECTORY "${UI_VM_DIR}"
  DEPENDS ${UI_ASM_FILES}
          "${CMAKE_CURRENT_SOURCE_DIR}/ui.q3asm"
          "${CMAKE_CURRENT_SOURCE_DIR}/ui_syscalls.asm"
  COMMENT "q3asm -> ui.qvm"
  VERBATIM
)

add_custom_target(ui DEPENDS "${UI_VM_DIR}/ui.qvm")

# --- always-debug build, mirrors ui.bat -DDEBUG passed unconditionally
# by debug.bat. Nested under the already-ignored vm/. ---
set(UI_VM_DEBUG_DIR "${UI_VM_DIR}/debug")
file(MAKE_DIRECTORY "${UI_VM_DEBUG_DIR}")

set(UI_DEBUG_ASM_FILES "")
foreach(src ${UI_SOURCES})
  get_filename_component(name "${src}" NAME_WE)
  if(IS_ABSOLUTE "${src}")
    set(src_path "${src}")
  else()
    set(src_path "${CMAKE_CURRENT_SOURCE_DIR}/${src}")
  endif()
  set(asm_out "${UI_VM_DEBUG_DIR}/${name}.asm")
  add_custom_command(
    OUTPUT "${asm_out}"
    COMMAND "${Q3LCC}" -DQ3_VM -DDEBUG
            -S -Wf-target=bytecode -Wf-g ${Q3_INCLUDE_FLAGS}
            "${src_path}"
    WORKING_DIRECTORY "${UI_VM_DEBUG_DIR}"
    DEPENDS "${src_path}"
    COMMENT "q3lcc -DDEBUG ui/${name}.c"
    VERBATIM
  )
  list(APPEND UI_DEBUG_ASM_FILES "${asm_out}")
endforeach()

add_custom_command(
  OUTPUT "${UI_VM_DEBUG_DIR}/ui.qvm"
  COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/ui_syscalls.asm" "${UI_VM_DIR}/ui_syscalls.asm"
  COMMAND "${Q3ASM}" -vq3 -r -m -v -f "${CMAKE_CURRENT_SOURCE_DIR}/ui"
  WORKING_DIRECTORY "${UI_VM_DEBUG_DIR}"
  DEPENDS ${UI_DEBUG_ASM_FILES}
          "${CMAKE_CURRENT_SOURCE_DIR}/ui.q3asm"
          "${CMAKE_CURRENT_SOURCE_DIR}/ui_syscalls.asm"
  COMMENT "q3asm -> debug/ui.qvm"
  VERBATIM
)

add_custom_target(ui_debug DEPENDS "${UI_VM_DEBUG_DIR}/ui.qvm")
