# Quake III Ultimate Arena Server Configuration

## 1. QL-Compatible Factories

A "factory" is a ready-made ruleset preset - pick one by name and it
auto-sets a whole bundle of cvars for you (most of what's documented in this
file), instead of configuring each one by hand. Set it with the `g_factory`
cvar (default `"ffa"`).

Factories live in `scripts/factories.txt` (the base set shipped with the
mod) plus any extra `scripts/*.factories` files a server admin drops in -
each is a JSON file listing factories by name. A factory can also inherit
from another factory and only override what's different, so add-on files
can tweak an existing preset without redefining it from scratch.

This doc doesn't try to list out every individual factory and what it sets,
since they're just config files and expected to keep growing over time -
open `scripts/factories.txt` (or your own `.factories` add-on) directly to
see exactly what a given factory changes.

**What this means, is that instead of starting your server with something like this:**
```
ioq3ded.exe +set fs_game missionpack2 +set g_gametype 4 +exec server_ca.cfg +map q3dm6
```
**Consider something like this instead:**
```
ioq3ded.exe +set fs_game missionpack2 +set g_factory "ca" +exec server_ca.cfg +map q3dm6
```
**Or, if you want to completely disable this behavior and set cvars manually, set g_factory to empty string:**
```
ioq3ded.exe +set fs_game missionpack2 +set g_factory "" +set g_gametype 4 +exec server_ca.cfg +map q3dm6
```

**Here is the list of default available values of g_factory**, from `scripts/factories.txt`:
| Title | Value | Description |
| --- | --- | --- |
| None/'Custom' |  | Doesn't touch any of the factory cvars ever. |
| Free For All | `ffa` | Default gametype settings. |
| Instagib FFA | `iffa` | Railgun and Gauntlet only. One shot, one kill. |
| Duel | `duel` | Default gametype settings. |
| CA Duel | `caduel` | Duel with Arena starting weapons and rules. |
| Team Deathmatch | `tdm` | Default gametype settings. |
| Clan Arena | `ca` | Default gametype settings. |
| Capture the Flag | `ctf` | Default gametype settings. |
| Instagib CTF | `ictf` | Railgun and Gauntlet only. One shot, one kill. |
| 1-Flag CTF | `oneflag` | Default gametype settings. |
| Overload | `obelisk` | Default gametype settings. |
| Harvester | `har` | Default gametype settings. |
| Arena | `arena` | Default gametype settings. |

---

## 2. Gametype Definitions

Which gametype the server actually runs is set with the `g_gametype` cvar
(default `0`), to one of the `GT_` enum values below. (A factory's
`g_gametype` cvar, if it sets one, takes precedence the same as any other
factory cvar - see Section 1.)

The GT_ enums in this mod are as follows:

| Value | Gametype Description |
| --- | --- |
| `0` | Free For All (FFA) |
| `1` | Tournament (Duel) |
| `2` | ~~`GT_SINGLE_PLAYER`~~ *(Inactive / Unused - QL uses this slot for Race)* |
| `3` | Team Deathmatch (TDM) |
| `4` | Clan Arena (Last Team Standing) |
| `5` | Capture the Flag |
| `6` | One Flag CTF |
| `7` | Overload |
| `8` | Harvester |
| `9` | ~~Freeze Tag~~ *(Inactive / Unused)* |
| `10` | ~~Domination~~ *(Inactive / Unused)* |
| `11` | ~~Attack & Defend~~ *(Inactive / Unused)* |
| `12` | ~~Red Rover~~ *(Inactive / Unused)* |
| `13` | ~~`GT_TEAMTOURNAMENT`~~ *(Inactive / Unused)* |
| `14` | Arena (Last Man Standing) |

*Note: These will change shortly to closer reflect that of Quake Live; this will happen when (hopefully) QL-compatible factories are implemented, whilst expanding upon them. I.e. g_freeze for all gametypes*

---

## 3. Server Gameplay & Physics Modifiers

These variables adjust general server settings.

| Variable | Default | Description |
| --- | --- | --- |
| `g_instagib` | `0` | Enables instagib in any gamemode. `0` = Off `1` = On 
| `g_teamVisibility` | `1` | Whether or not server allows teammates to see eachothers' positions globally. `0` = Vanilla behavior; don't send any new messages; players with cg_drawFriend < 2 will raycast to hide known within PVS. `1` = Send 'tpos' message in team games, allowing allies to see eachother. |
| `g_itemVisibility` | `1` | Whether or not server allows players in match to receive item positions, respawn timers, etc. `0` = Vanilla behavior; don't send any new messages; nobody is allowed to see item positions and timers. `1` = Send 'ipos' message with item locations and stats, such as respawn times. |
| `g_allSpec` | `0` | Whether or not dead players in round-based gamemodes can spectate everybody. `0` = Default team-only dead spectators. `1` = Dead players can spectate everybody, including enemies. |
| `g_allowHandicap` | `0` | Master toggle for whether a connecting client's userinfo `handicap` value (health scaling) is honored at all. `0` = Ignored, everyone uses the normal health limit. `1` = Client-set handicap percentage is applied. |
| `dmflags` | `0` | Vanilla deathmatch flags bitmask (no-armor, no-health, no-falling-damage, etc - see original Q3 documentation for the bit meanings). C global is `g_dmflags`. |
| --- | --- | --- |
| `fraglimit` | `20` | Frag/score limit for non-round-based gametypes. C global is `g_fraglimit`. |
| `timelimit` | `0` | Match time limit in minutes, `0` = unlimited. C global is `g_timelimit`. |
| `capturelimit` | `8` | Flag capture limit (CTF/1-Flag CTF). C global is `g_capturelimit`. |
| `roundlimit` | `10` | Number of round wins needed to win the match, for round-based gametypes (e.g. Clan Arena). C global is `g_roundlimit` - like vanilla `fraglimit`/`timelimit`/`capturelimit`, the `g_` is prefixed on the C variable for symbol cleanliness only, not the actual cvar. |
| `roundtimelimit` | `180` | Maximum duration of a single round in seconds, for round-based gametypes. Same `g_`-prefix-on-C-global-only note as `roundlimit` above. |
| --- | --- | --- |
| `g_warmup` | `20` | Warmup countdown length in seconds before a match goes live. |
| `g_fastWeaponSwitch` | `0` | Instant weapon switching with no raise/lower delay. `1` = On, `0` = Off. |
| `g_friendlyFire` | `0` | Whether teammates can damage each other. `1` = On, `0` = Off. |
| `g_forcerespawn` | `20` | Seconds a dead player can wait before being force-respawned. |
| `g_1FRespawn` | `0` | One Flag CTF's neutral flag respawn behavior. |
| `g_gravity` | `800` | World gravity. |
| `g_speed` | `320` | Player movement speed. |
| `g_knockback` | `1000` | Damage knockback force multiplier. |
| `g_quadDamageFactor` | `3` | Quad Damage powerup's damage multiplier. |

---

## 4. Game Balancing & Customization

Weapon systems can be fine-tuned via ammunition limits, velocity settings, structural behavior, and exact damage configurations. 

For variables containing a wildcard symbol (*X*), swap the token out for one of the following shortcodes:
*   `MG` (Machinegun), `SG` (Shotgun), `GL` (Grenade Launcher), `RL` (Rocket Launcher), `LG` (Lightning Gun), `RG` (Railgun), `PG` (Plasma Gun), `BFG` (BFG10K), `NG` (Nailgun), `PL` (Prox Launcher), `CG` (Chaingun), `HMG` (Heavy Machine Gun).

| Variable | Default | Description |
| --- | --- | --- |
| `g_noSelfDamage` | `0` | Disables splash and environmental damage dealt to oneself (`1` = Disabled, `0` = Standard self-damage behavior). |
| `g_startingHealth` | `0` | Overrides the starting health pool upon a standard player respawn. `0` (or below) falls back to the engine's default health soft limit rather than literally spawning with `0` HP. |
| `g_startingHealthBonus` | `0` | Adds bonus health on top of max health on spawn, clamped between `0` and the player's max health stat. |
| `g_startingArmor` | `0` | Defines the starting armor pool upon a standard player respawn (Range: `0` to `200`). |
| --- | --- | --- |
| `g_startingWeapon` | `0` | Selects a specific standalone primary weapon id for players to spawn with by default (`0` = Gauntlet/Machinegun baseline). |
| `g_startingAmmo_*x*` | ` ` | Sets the baseline starting ammunition reserve given to players on spawn for the specified weapon identifier *x* (lowercase). |
| `g_damage_*x*` | ` ` | Sets the explicit base direct-hit damage value for the specified weapon code *x* (lowercase) (Range: `0` to `999`). `g_damageTeamMG` (team-specific Machinegun damage) no longer exists. `g_damage_pl` (Prox Launcher) now defaults to `0` - it only ever splash-damages, matching TA/QL convention. |
| `g_splashdamage_*x*` | ` ` | Sets the impact blast damage coefficient for splash-damage tracking weapons (Applicable codes: `gl`, `rl`, `pg`, `bfg`, `pl`). |
| `g_splashradius_*x*` | ` ` | Sets the radial blast distance falloff boundary for splash-damage tracking weapons (Applicable codes: `gl`, `rl`, `pg`, `bfg`, `pl`). |
| `g_velocity_rl` | `900` | Sets the physical travel velocity speed of fired Rocket Launcher projectiles. |
| `g_sgPellets` | `11` | Sets the exact number of independent hit-scan pellets generated per primary Shotgun blast. |
| `g_sgPelletSpread` | `700` | Configures the horizontal and vertical dispersion pattern width of Shotgun pellets. |
| `g_nailBounce` | `1` | Toggles Quake Live-style bouncing projectiles for the Nailgun (`1` = On, `0` = Off). |
| --- | --- | --- |
| `g_ammoRespawn` | `5` | Ammo pickup respawn pacing configuration, in seconds. Applies to all gametypes - the separate team-gametype respawn timer cvars below no longer exist. |
| `g_armorRespawn` | `25` | Armor pickup respawn pacing configuration, in seconds. |
| `g_healthRespawn` | `35` | Small and standard health item respawn pacing configuration, in seconds. |
| `g_megahealthRespawn` | `35` | Megahealth item respawn pacing configuration, in seconds. |
| `g_powerupRespawn` | `120` | Major Powerup item respawn pacing configuration, in seconds. |
| `g_holdableRespawn` | `60` | Inventory Holdable item respawn pacing configuration, in seconds. |
| --- | --- | --- |
| `g_grappleDelayTime` | `400` | Grapple delay time. |
| `g_grappleHoldTime` | `0` | Maximum duration a line can actively latch onto a surface in seconds (`0` allows infinite attachment). |
| `g_grappleSpeed` | `1600` | Grapple deploy speed in U/s |
| `g_grapplePull` | `800` | Grapple pull speed in U/s. |
| `g_damage_gh` | `10` | Grapple hook damage amount (`0` to disable damage). Renamed from `g_grappleDamage`; default also changed from `2`. |
| `g_railJump` | `0` | Enables rail jump (`1` = On, `0` = Off). |
| `g_railJumpDamage` | `100` | Damage if for rail jump (if enabled) |

---

### Item/weapon flagged cvars

*   **g_startingWeapons:** Set starting weapon inventories (replaces the old `wpflags` cvar, which no longer exists). *(Note: Players always retain the Gauntlet and Machinegun regardless of mask modification settings).* Uses its own bitweight layout, **different** from `removeweapon`/`removeammo` below - see its own table first.
    *   **`g_grapple`** *(not a real factory cvar itself - do not set directly)*: purely derived from bit `512` of `g_startingWeapons` above, read-only (`CVAR_ROM`). Toggling the Grappling Hook bit in `g_startingWeapons` is what actually controls this.

`g_startingWeapons` bitweight layout (default `3` = bits 1+2, i.e. Gauntlet+Machinegun, both already always given regardless):

| Bitweight Integer | Targeted Asset Name |
| --- | --- |
| `1` | Gauntlet |
| `2` | Machinegun |
| `4` | Shotgun |
| `8` | Grenade Launcher |
| `16` | Rocket Launcher |
| `32` | Lightning Gun |
| `64` | Railgun |
| `128` | Plasma Gun |
| `256` | BFG10K |
| `512` | Grappling Hook |
| `1024` | Nailgun |
| `2048` | Prox Launcher |
| `4096` | Chaingun |
| `8192` | Heavy Machine Gun |


*   **removeweapon:** Drops matching weapon pick-ups directly out of the active map context.
*   **removeammo:** Drops corresponding weapon-specific ammunition cases directly out of the active map context.

`removeweapon`/`removeammo` bitweight layout (unchanged from before `060`):

| Bitweight Integer | Targeted Asset Name |
| --- | --- |
| `1` | Machinegun |
| `2` | Shotgun |
| `4` | Grenade Launcher |
| `8` | Rocket Launcher |
| `16` | Lightning Gun |
| `32` | Railgun |
| `64` | Plasma Gun |
| `128` | BFG10K |
| `256` | Nailgun |
| `512` | Prox Launcher |
| `1024` | Chaingun |
| `2048` | Heavy Machine Gun |

### Item filter flags (`removeitem`)

Filters health resources, protection levels, and utility inventories out of the physical map layouts.

| Bitweight Integer | Targeted Asset Name |
| --- | --- |
| `1` | Armor Shard |
| `2` | Combat Armor (Yellow) |
| `4` | Body Armor (Red) |
| `8` | Small Health |
| `16` | Medium Health |
| `32` | Large Health |
| `64` | Megahealth |
| `128` | Holdable Teleporter |
| `256` | Holdable Medkit |
| `512` | Holdable Kamikaze |
| `1024` | Holdable Portal |
| `2048` | Holdable Invulnerability |
| `4096` | Armor Jacket (Green) |

### Powerup filter flags (`removepowerup`)

Powerup spawn filters.

| Bitweight Integer | Targeted Asset Name |
| --- | --- |
| `1` | Quad Damage |
| `2` | Environmental Battle Suit |
| `4` | Haste |
| `8` | Invisibility |
| `16` | Regeneration |
| `32` | Flight |
| `64` | Scout |
| `128` | Guard |
| `256` | Doubler |
| `512` | Ammo Regen |

---

## 5. Non-Factory Cvars

Everything documented above is settable via a [factory preset](#1-ql-compatible-factories)
(see `GFACTORY_CVARS` in `bg_newgame.h` if you want the exact permitted
list). These two are not - a factory can't set them, so they always need
to be configured directly (server.cfg, command line, or console):

| Variable | Default | Description |
| --- | --- | --- |
| `g_unlagged` | `1` | Enables unlagged code. `0` = Off `1` = On |
| `g_loadCustomEnts` | `0` | Whether or not to load .ent override file corresponding to the map's file name. `0` = Off. `1` = Load custom .ent files. |
