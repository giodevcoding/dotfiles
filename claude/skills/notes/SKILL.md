# Working Notes Tracker

Track "revisit this later" thoughts that come up mid-task (e.g. "removing this now, but check the callers in service X later") in a per-repo file: `.claude/notes.md` at the root of the current repo.

This is for fast, low-friction jotting during work — not a replacement for Jira. Jira tickets are for stakeholder-visible tracking; this file is for your own and Claude's short-lived working memory while heads-down in a repo. The file IS committed to git (so teammates and future-you see open concerns), but open notes should be cleared before merging — see "check" below.

## Ticket tagging from branch name

Branches follow `ffp-1234/description` (lowercase project key + dash + number, then `/`, then description). When adding a note, run `git branch --show-current`, take everything before the first `/`, uppercase it (e.g. `ffp-1234` → `FFP-1234`), and tag the note with it automatically — no need to ask the user for the ticket id. If the branch doesn't match that pattern (e.g. `master`, `main`, no `/`), add the note untagged.

## File format

`.claude/notes.md`, created on first use if missing:

```markdown
# Notes

## Open

- [ ] 2026-08-13 [FFP-1234] removing legacy auth shim, need to check callers in billing-service later (src/auth/legacy.ts)
- [ ] 2026-08-13 hardcoded timeout, should come from config

## Resolved

- [x] 2026-08-10 [FFP-1189] revisit pagination default — resolved: bumped to 50, confirmed with design
```

Each entry: date, auto-derived `[TICKET-ID]` tag if the branch matched, free text, optional trailing file/path in parens. Resolved entries keep a short "resolved: ..." note, not deleted — it's a log, not a scratch pad.

## Actions

Dispatch on what the user asks for (they may invoke as `/notes <args>` or just ask in plain language — treat both the same):

**Add a note** — user gives a note to jot down, or says something like "note that" / "remember to check X later" mid-task:
- Create `.claude/notes.md` from the template above if it doesn't exist.
- Derive the ticket tag from the current branch (see above).
- Append a new `- [ ] YYYY-MM-DD [TICKET-ID] ...` line under `## Open` (omit the tag if branch didn't match).
- Confirm briefly (one line) — don't make a big deal of it.

**List open notes** — user asks to see notes, or says "what notes do I have":
- Read `.claude/notes.md`, print the `## Open` section. If empty or file missing, say so.
- If the user asks for "this ticket" / "current ticket", derive the tag from the branch and filter to matching lines (plus untagged ones only if they ask for those too).

**Resolve a note** — user says a note is done / no longer relevant, referencing it by text or position:
- Move the matching line from `## Open` to `## Resolved`, change `[ ]` to `[x]`, append `— resolved: <short reason if given>`.

**Pre-merge check** — user asks to check before merging/opening a PR, or this is invoked as part of a PR workflow:
- Derive the current ticket tag from the branch.
- Read `## Open` section, filter to notes matching that ticket (plus untagged ones, since those aren't tied to any ticket).
- If any remain, surface each clearly and ask the user whether to resolve it now, move it to the Jira ticket, or consciously leave it open and merge anyway. Don't silently let it slide — the point of this action is to force the decision.
- If none, say so briefly.

## Proactive surfacing (session start)

If the user wants notes to surface automatically at the start of a session in a given repo (not just when asked), that requires a `SessionStart` hook wired into that repo's `.claude/settings.json` — hooks are what the harness runs automatically, this skill's instructions alone only fire when invoked. If asked to set this up, use the `update-config` skill to add a `SessionStart` hook that prints the Open section (ideally filtered to the current branch's ticket, same derivation as above) if `.claude/notes.md` has content. Confirm with the user before writing the hook — it changes repo-shared config.
