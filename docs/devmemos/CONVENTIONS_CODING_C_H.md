# Coding conventions: ~Dimmskii tags (.c / .h edits)

Every code change relative to the "original" upstream source (Kr3m's
missionpackplus fork of id's Quake III Team Arena) must stay visible in the
diff, not just disappear into git history. The convention applies to any
`.c`/`.h` file under `src/` that pre-exists in this codebase (inherited from
Kr3m/missionpackplus) - brand-new files we author outright don't need
per-line tags, just a single authorship header.

## The rule

- **Never delete** an upstream line outright. Comment it out in place -
  `//` for one/few lines, a block comment for larger spans - so the
  original stays visible in the diff.
- Put the replacement/addition **directly below** the commented-out
  original, opened with `// ~Dimmskii`.
  - **Single-line** addition/replacement: a trailing (or leading)
    `// ~Dimmskii` on that same line is enough.
  - **Multi-line** addition: wrap the whole block - `// ~Dimmskii` on its
    own line before, `// END Dimmskii` (or `// END DIMMSKII`) on its own
    line after. Never trailing-comment only the first line of a multi-line
    block.
- **Lump into existing `~Dimmskii` regions.** When adding a new method,
  prototype, declaration, or field near an existing `~Dimmskii` block (or
  where one already brackets that area), extend that block rather than
  opening a fresh island of tags. Prefer fewer, larger tagged regions over
  many scattered single-line tags.
- When removing code that lives *inside* an existing `// ~Dimmskii` /
  `// END Dimmskii` region, don't delete the closing tag along with it if
  the region continues past what you removed - the tags bound the whole
  region, not just the lines you touched.
- **You may comment out a whole block if it's clearer** and rewrite the
  replacement immediately below it - this is allowed even for fairly large
  spans, not just single lines - **unless you're already inside our own
  custom code that's already `~Dimmskii`-tagged** (i.e. code we added
  previously, not inherited from Kr3m/missionpackplus). In that case just
  edit it directly - there's no upstream original to preserve.
- **When replacing a line that's already been through a prior `~Dimmskii`
  replacement, keep the older commented-out version too** - don't collapse
  down to just the immediately-preceding line. Stack them: original upstream
  line commented out, prior replacement commented out below it, new
  replacement below that. See
  [`1303564`](https://github.com/Gobot2969/missionpack2/commit/130356447af2651205b63e08d1de16eb083cb193)
  ("Register team HUD media unconditionally, not gated on gametype") -
  it comments out both the original vanilla `cgs.gametype >= GT_TEAM` line
  *and* the already-`~Dimmskii`-tagged `GT_IsTeam(cgs.gametype)` line that
  had replaced it, then adds the new unconditional `{ // ~Dimmskii` below
  both. Exemplary for the *tagging/layering* itself, even though the fix
  didn't end up sticking - it was reverted in `f9abd61` once the actual
  root cause (a disabled gametype-change session reset in `g_session.c`)
  was fixed instead, and the media no longer needed unconditional
  registration.

## Why

The user (Dmitri) maintains this mod as a diff against Kr3m/missionpackplus
and wants every deviation traceable and greppable (`grep -n Dimmskii`)
directly in the source, not just in commit messages.

## How to apply

Any time you edit a `.c`/`.h` file under `src/` that pre-exists in this
codebase, follow this convention for new edits, and check that existing
`~Dimmskii`/`END Dimmskii` tags around code you touch remain balanced
afterward.

Reference examples in git history: `a26df65` ("Exemplary comment fix for
Claude CLI"), `ff30dec` ("QL-ify g_velocityRL to g_velocity_rl").

## Not every file needs this - check the top-of-file header first

The convention exists to keep OUR deviations from the Kr3m/missionpackplus
baseline traceable. Files that never had a Kr3m/id baseline to begin with -
because we authored them outright - don't have an "original" to preserve,
so the strict comment-out-and-tag treatment doesn't apply to edits made
inside them. Look at the top few lines of the file before editing:

- **`// By Dimmskii`** or **`// ~Dimmskii`** right at the top of the file -
  ours outright, edit freely. Examples: `bg_newgame.h` ("By Dimmskii"),
  `bg_cvar.h` ("By Dimmskii"), `g_newgame.h` ("By Dimmskii"), `cg_olddraw.c`
  ("~Dimmskii" - this one is partly a faithful port of vanilla
  `#ifndef MISSIONPACK` status-bar code from base Q3, assembled into a new
  file for this mod's old-HUD feature; it's still ours outright since the
  *file* didn't exist upstream, but see its own header comment for the
  porting-fidelity notes on individual functions).
- **`// Copyright (C) 1999-2000 Id Software, Inc.`** - genuine upstream
  baseline (`g_session.c` is one). These need the full convention.
- **Anything else** (e.g. `g_rotation.c`'s `// Public Domain`, presumably a
  third-party contribution rather than id/Kr3m or Dimmskii/UA) - not
  clearly ours and not clearly the Kr3m/id baseline either. If unsure which
  bucket a file like this falls in, ask rather than assume.

## Reference repos for comparison

Three different repos, for three different comparison directions - don't
mix them up:

- **Upstream baseline (what counts as "original" for this whole
  convention)**: [Kr3m/missionpackplus](https://github.com/Kr3m/missionpackplus),
  HEAD revision. This is the actual fork point/baseline this mod diverges
  from - use it to determine whether a given line is genuinely upstream or
  already one of our own past changes.
- **"Away-from" tracking (how far we've drifted from stock engine
  behavior)**: [ioquake/ioq3](https://github.com/ioquake/ioq3). Useful when
  a bug might be a divergence from vanilla base Q3/TA engine behavior
  rather than something Kr3m or we introduced - missionpackplus itself
  forked from an ioq3-family base, so this is the layer beneath that.
- **"Toward" tracking (the direction most new work has been heading)**:
  QL-SRP (hosted privately, not a public repo - already cited in several
  existing code comments as the reference for QL-shaped behavior we're
  porting in - cvar-sync configstrings, ownerdraw semantics, etc.) - use
  it when the question is "how does real Quake Live do this," not "what
  did Kr3m/id originally do."

  **Earmark - full mission statement to follow in a separate file:**
  QL-SRP-direction ports are NOT a mandate to become QL-only. This mod's
  own gametypes (Arena, LMS, etc.) and whatever's still planned for QL
  compat all need to keep working across vanilla/VQ3, TA, and QL-compatible
  HUD styles - don't let a QL-shaped port narrow or break support for the
  older HUD paths this mod also promises to keep drawing everything
  through.

All three are already cloned locally (as of this writing:
`/opt/openclaw/missionpackplus`, `/opt/openclaw/ioq3_src`,
`/opt/openclaw/QL-SRP`) - **check for an existing local copy and prompt the
user whether to proceed with it as-is (it may be stale) or pull/re-clone
first, rather than assuming either way.** If no local copy exists at all,
prompt before cloning one.
