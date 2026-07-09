# Translates cgame_ua.bat: compiles each listed .c (drawn from both
# code/cgame and shared code/game / code/ui files) to bytecode .asm via
# q3lcc, then links them per cgame_ta.q3asm via q3asm into cgame.qvm.

set(CGAME_VM_DIR "${CMAKE_CURRENT_SOURCE_DIR}/vm")
file(MAKE_DIRECTORY "${CGAME_VM_DIR}")
set(GAME_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../game")
set(UI_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../ui")

# (relative-to-module-dir source path)
set(CGAME_SOURCES
  "${GAME_DIR}/bg_misc.c"
  "${GAME_DIR}/bg_newgame.c"
  "${GAME_DIR}/bg_pmove.c"
  "${GAME_DIR}/bg_slidemove.c"
  "${GAME_DIR}/bg_lib.c"
  "${GAME_DIR}/q_math.c"
  "${GAME_DIR}/q_shared.c"
  cg_consolecmds.c
  cg_draw.c
  cg_drawtools.c
  cg_effects.c
  cg_ents.c
  cg_event.c
  cg_info.c
  cg_localents.c
  cg_main.c
  cg_marks.c
  cg_players.c
  cg_playerstate.c
  cg_predict.c
  cg_scoreboard.c
  cg_servercmds.c
  cg_snapshot.c
  cg_view.c
  cg_weapons.c
  "${UI_DIR}/ui_shared.c"
  cg_newdraw.c
)

set(CGAME_ASM_FILES "")
foreach(src ${CGAME_SOURCES})
  get_filename_component(name "${src}" NAME_WE)
  if(IS_ABSOLUTE "${src}")
    set(src_path "${src}")
  else()
    set(src_path "${CMAKE_CURRENT_SOURCE_DIR}/${src}")
  endif()
  set(asm_out "${CGAME_VM_DIR}/${name}.asm")
  add_custom_command(
    OUTPUT "${asm_out}"
    COMMAND "${Q3LCC}" -DQ3_VM -DCGAME ${Q3_DEBUG_FLAG}
            -S -Wf-target=bytecode -Wf-g ${Q3_INCLUDE_FLAGS}
            "${src_path}"
    WORKING_DIRECTORY "${CGAME_VM_DIR}"
    DEPENDS "${src_path}"
    COMMENT "q3lcc cgame/${name}.c"
    VERBATIM
  )
  list(APPEND CGAME_ASM_FILES "${asm_out}")
endforeach()

add_custom_command(
  OUTPUT "${CGAME_VM_DIR}/cgame.qvm"
  COMMAND "${Q3ASM}" -vq3 -r -m -v -f "${CMAKE_CURRENT_SOURCE_DIR}/cgame_ta"
  WORKING_DIRECTORY "${CGAME_VM_DIR}"
  DEPENDS ${CGAME_ASM_FILES}
          "${CMAKE_CURRENT_SOURCE_DIR}/cgame_ta.q3asm"
          "${CMAKE_CURRENT_SOURCE_DIR}/cg_syscalls.asm"
  COMMENT "q3asm -> cgame.qvm"
  VERBATIM
)

add_custom_target(cgame DEPENDS "${CGAME_VM_DIR}/cgame.qvm")

# --- always-debug build, mirrors cgame_ua.bat -DDEBUG passed
# unconditionally by debug.bat. Nested under the already-ignored vm/. ---
set(CGAME_VM_DEBUG_DIR "${CGAME_VM_DIR}/debug")
file(MAKE_DIRECTORY "${CGAME_VM_DEBUG_DIR}")

set(CGAME_DEBUG_ASM_FILES "")
foreach(src ${CGAME_SOURCES})
  get_filename_component(name "${src}" NAME_WE)
  if(IS_ABSOLUTE "${src}")
    set(src_path "${src}")
  else()
    set(src_path "${CMAKE_CURRENT_SOURCE_DIR}/${src}")
  endif()
  set(asm_out "${CGAME_VM_DEBUG_DIR}/${name}.asm")
  add_custom_command(
    OUTPUT "${asm_out}"
    COMMAND "${Q3LCC}" -DQ3_VM -DCGAME -DDEBUG
            -S -Wf-target=bytecode -Wf-g ${Q3_INCLUDE_FLAGS}
            "${src_path}"
    WORKING_DIRECTORY "${CGAME_VM_DEBUG_DIR}"
    DEPENDS "${src_path}"
    COMMENT "q3lcc -DDEBUG cgame/${name}.c"
    VERBATIM
  )
  list(APPEND CGAME_DEBUG_ASM_FILES "${asm_out}")
endforeach()

add_custom_command(
  OUTPUT "${CGAME_VM_DEBUG_DIR}/cgame.qvm"
  COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/cg_syscalls.asm" "${CGAME_VM_DIR}/cg_syscalls.asm"
  COMMAND "${Q3ASM}" -vq3 -r -m -v -f "${CMAKE_CURRENT_SOURCE_DIR}/cgame_ta"
  WORKING_DIRECTORY "${CGAME_VM_DEBUG_DIR}"
  DEPENDS ${CGAME_DEBUG_ASM_FILES}
          "${CMAKE_CURRENT_SOURCE_DIR}/cgame_ta.q3asm"
          "${CMAKE_CURRENT_SOURCE_DIR}/cg_syscalls.asm"
  COMMENT "q3asm -> debug/cgame.qvm"
  VERBATIM
)

add_custom_target(cgame_debug DEPENDS "${CGAME_VM_DEBUG_DIR}/cgame.qvm")
