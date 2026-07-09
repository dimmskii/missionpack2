# Translates game_ua.bat: compiles each listed .c to bytecode .asm via
# q3lcc, then links them per game_ta.q3asm via q3asm into qagame.qvm.
# Source list and flags are copied verbatim from game_ua.bat.

set(GAME_VM_DIR "${CMAKE_CURRENT_SOURCE_DIR}/vm")
file(MAKE_DIRECTORY "${GAME_VM_DIR}")

set(GAME_SOURCES
  ../common/jsmndr.c
  g_main.c
  ai_chat.c
  ai_cmd.c
  ai_dmnet.c
  ai_dmq3.c
  ai_main.c
  ai_team.c
  ai_vcmd.c
  bg_lib.c
  bg_misc.c
  bg_newgame.c
  bg_pmove.c
  bg_slidemove.c
  g_active.c
  g_arena.c
  g_newgame.c
  g_arenas.c
  g_bot.c
  g_client.c
  g_cmds.c
  g_combat.c
  g_items.c
  g_mem.c
  g_misc.c
  g_missile.c
  g_mover.c
  g_rotation.c
  g_session.c
  g_spawn.c
  g_svcmds.c
  g_target.c
  g_team.c
  g_trigger.c
  g_unlagged.c
  g_utils.c
  g_weapon.c
  q_math.c
  q_shared.c
)

set(GAME_ASM_FILES "")
foreach(src ${GAME_SOURCES})
  get_filename_component(name "${src}" NAME_WE)
  set(asm_out "${GAME_VM_DIR}/${name}.asm")
  add_custom_command(
    OUTPUT "${asm_out}"
    COMMAND "${Q3LCC}" -DQ3_VM ${Q3_DEBUG_FLAG}
            -S -Wf-target=bytecode -Wf-g ${Q3_INCLUDE_FLAGS}
            "${CMAKE_CURRENT_SOURCE_DIR}/${src}"
    WORKING_DIRECTORY "${GAME_VM_DIR}"
    DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/${src}"
    COMMENT "q3lcc game/${src}"
    VERBATIM
  )
  list(APPEND GAME_ASM_FILES "${asm_out}")
endforeach()

add_custom_command(
  OUTPUT "${GAME_VM_DIR}/qagame.qvm"
  COMMAND "${Q3ASM}" -vq3 -r -m -v -f "${CMAKE_CURRENT_SOURCE_DIR}/game_ta"
  WORKING_DIRECTORY "${GAME_VM_DIR}"
  DEPENDS ${GAME_ASM_FILES}
          "${CMAKE_CURRENT_SOURCE_DIR}/game_ta.q3asm"
          "${CMAKE_CURRENT_SOURCE_DIR}/g_syscalls.asm"
  COMMENT "q3asm -> qagame.qvm"
  VERBATIM
)

add_custom_target(qagame DEPENDS "${GAME_VM_DIR}/qagame.qvm")

# --- always-debug build, mirrors debug.bat unconditionally passing
# -DDEBUG (independent of the Q3_DEBUG_VM option above). Built into
# vm/debug/ - nested under the already-ignored vm/ dir - to avoid
# colliding with the regular qagame.qvm output. ---
set(GAME_VM_DEBUG_DIR "${GAME_VM_DIR}/debug")
file(MAKE_DIRECTORY "${GAME_VM_DEBUG_DIR}")

set(GAME_DEBUG_ASM_FILES "")
foreach(src ${GAME_SOURCES})
  get_filename_component(name "${src}" NAME_WE)
  set(asm_out "${GAME_VM_DEBUG_DIR}/${name}.asm")
  add_custom_command(
    OUTPUT "${asm_out}"
    COMMAND "${Q3LCC}" -DQ3_VM -DDEBUG
            -S -Wf-target=bytecode -Wf-g ${Q3_INCLUDE_FLAGS}
            "${CMAKE_CURRENT_SOURCE_DIR}/${src}"
    WORKING_DIRECTORY "${GAME_VM_DEBUG_DIR}"
    DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/${src}"
    COMMENT "q3lcc -DDEBUG game/${src}"
    VERBATIM
  )
  list(APPEND GAME_DEBUG_ASM_FILES "${asm_out}")
endforeach()

add_custom_command(
  OUTPUT "${GAME_VM_DEBUG_DIR}/qagame.qvm"
  COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/g_syscalls.asm" "${GAME_VM_DIR}/g_syscalls.asm"
  COMMAND "${Q3ASM}" -vq3 -r -m -v -f "${CMAKE_CURRENT_SOURCE_DIR}/game_ta"
  WORKING_DIRECTORY "${GAME_VM_DEBUG_DIR}"
  DEPENDS ${GAME_DEBUG_ASM_FILES}
          "${CMAKE_CURRENT_SOURCE_DIR}/game_ta.q3asm"
          "${CMAKE_CURRENT_SOURCE_DIR}/g_syscalls.asm"
  COMMENT "q3asm -> debug/qagame.qvm"
  VERBATIM
)

add_custom_target(qagame_debug DEPENDS "${GAME_VM_DEBUG_DIR}/qagame.qvm")
