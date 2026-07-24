# Workflow: testing with debug prints without touching the real source tree

When a fix needs live dedicated-server verification (console prints, counters,
timing) but you don't want temporary debug lines landing in the real
project's tracked `.c` files - even transiently - build and test from an
isolated copy instead, and only ever move the disposable build artifact
(`pak061.pk3`) back into the real project.

## Steps

1. **Copy the project**, fixes and all, to an isolated location outside the
   repo (e.g. `~/claude-workspace/mp2-test-run/missionpack2`). This is a full
   `cp -a` of `missionpack2/` - a few hundred MB, seconds to copy.
2. **Symlink the static, read-only assets** the engine needs to actually run
   next to the copy - `baseq3/` and the `ioq3ded.x86_64` binary - rather than
   copying them. They're large (hundreds of MB) and never modified, so a
   symlink from the isolated run directory back to the real `~/quake3/baseq3`
   and `~/quake3/ioq3ded.x86_64` is sufficient and avoids duplicating them.
3. **Add temporary debug instrumentation only in the isolated copy** (e.g.
   `G_Printf("TESTDBG: ...")` at the exact points being verified). The real
   project's source is never touched by this step.
4. **Build the isolated copy** with its own throwaway CMake build directory
   (`cmake -S <isolated>/src -B <throwaway-build-dir>`, then
   `cmake --build ... --target release`).
5. **Back up the real project's current `pak061.pk3`** before touching it
   (`cp -a pak061.pk3 pak061.pk3.clean-backup` somewhere outside the repo).
   Verify first that it's actually clean (see the gotcha below) rather than
   assuming any existing backup or build artifact is debug-free.
6. **Copy the isolated build's `pak061.pk3`** into the real project's gamedir
   root, overwriting the real one temporarily. This is the only artifact that
   crosses back into the real project, and it's gitignored/disposable.
7. **Run the dedicated server test** from the real `~/quake3` environment
   (`ioq3ded.x86_64 +set fs_game missionpack2 ...`), so the test exercises the
   exact same engine/baseq3/paths as any other session - only the mod's own
   `pak061.pk3` differs (debug build vs normal).
8. **Restore cleanliness afterward**: rebuild `pak061.pk3` directly from the
   real project's actual (debug-print-free) source - don't just restore a
   backup blindly (see gotcha) - so the real project's build artifact matches
   its real source again.

## Gotcha: a stale backup can silently reintroduce old debug prints

If a debug-instrumented `pak061.pk3` was ever built **directly in the real
project** in an earlier session/turn (source added, built, then only the
*source* reverted via `git checkout --` without rebuilding), the real
project's `pak061.pk3` on disk stays debug-instrumented even though the
source is clean again. Backing that up and later "restoring" it just brings
the stale debug build back - it was never clean to begin with.

**Fix:** don't trust an existing `pak061.pk3` (or a backup of it) to be
clean by assumption. After restoring, always grep the QVM for the debug
marker to confirm:

```sh
unzip -p pak061.pk3 vm/qagame.qvm | strings | grep -c TESTDBG   # expect 0
```

If it's not actually 0, the real fix is to rebuild `pak061.pk3` **directly
from the real project's current source** (touch all `.c` files to force a
full recompile, then `cmake --build ... --target release`) rather than
restoring any cached/backed-up binary - that's the only way to guarantee the
artifact matches the source.

## Why this is worth the extra steps

- The real project's tracked files are never at risk of an accidental
  `git add`/commit picking up throwaway debug lines.
- The only thing that crosses back into the real project is a build
  artifact that's already gitignored and gets rebuilt fresh anyway.
- Symlinking the big static asset dirs instead of copying them keeps the
  isolated copy cheap and fast to set up per debugging session.
