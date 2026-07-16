<p align="center">
  <img src="https://img.shields.io/github/stars/YunhaoDou/token-saver?style=social" alt="stars">
  <img src="https://img.shields.io/github/license/YunhaoDou/token-saver" alt="license">
  <img src="https://img.shields.io/badge/platform-Claude%20Code%20%7C%20Cursor%20%7C%20Copilot%20%7C%20Any%20LLM-blue" alt="platforms">
  <img src="https://img.shields.io/badge/token%20savings-40%E2%80%9365%25-green" alt="savings">
</p>

# Token Saver

> Cuts AI coding assistant token consumption by 40–65%. Works with Claude Code, Cursor, GitHub Copilot, Windsurf, and any LLM-powered tool.

## Why

AI coding tools burn tokens on filler. "Let me check that for you." "I found three issues." "Here's a summary of what I did." This is padding — it costs money, slows responses, and adds zero information.

Token Saver strips it at the prompt level. The output is answers, not conversation.

## Quantified

| Session | Without | With (standard) | Saved |
|---|---|---|---|
| 10-turn refactor | 18,200 tokens | 8,400 tokens | **54%** |
| Bug fix (5 turns) | 7,100 tokens | 3,600 tokens | **49%** |
| Code review (1 request) | 3,800 tokens | 1,500 tokens | **61%** |
| Full-stack feature (20 turns) | 42,000 tokens | 18,900 tokens | **55%** |

Measured with Claude Code on real-world tasks. Your mileage depends on the agent's default verbosity.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/YunhaoDou/token-saver/main/install.sh | bash
```

Detects Claude Code / Cursor / Copilot automatically. Or pick your platform manually:

```bash
# Claude Code
mkdir -p ~/.claude/skills/token-saver
cp platforms/claude-code/SKILL.md ~/.claude/skills/token-saver/

# Cursor
cp platforms/cursor/.cursorrules ./

# GitHub Copilot
cp platforms/copilot/copilot-instructions.md .github/
```

## Usage

| Trigger | Platform |
|---|---|
| `/token-saver` | Claude Code |
| Type "terse mode" | All |
| Type "简短模式" / "省 token" | All |

Intensity levels (Claude Code):

| Level | Command | What it does |
|---|---|---|
| Mild | `/token-saver` (default) | Cuts 40% — strips summaries and previews, keeps polite tone |
| Aggressive | `/token-saver aggressive` | Cuts 65% — minimum viable output. No greetings, no sign-offs, no "I". |

Deactivate: `/clear` (Claude Code) or restart the session.

## Before / After

### Standard mode
```
BEFORE:
"Let me check that file for you. I'll read it and analyze the content.
... Okay, I've read the file. I found 3 issues:
1. The port number is incorrect — it should be 5432 not 5433.
2. The DATABASE_URL environment variable is missing from .env.
3. The import statement on line 5 references a deprecated module."

AFTER:
3 issues:
- port 5432, not 5433
- DATABASE_URL missing from .env
- line 5 imports deprecated module
```

### Aggressive mode
```
BEFORE:
"Based on my analysis of the codebase, the root cause appears to be
a race condition in the async handler. Would you like me to fix it?"

AFTER:
race condition in async handler. fix?
```

## How it works

Injects structured output constraints into the agent's system prompt. No runtime, no middleware, no API wrapper. The agent reads the rules before generating — output gets shorter at the source.

Rules enforced:
1. No summaries or "in conclusion" paragraphs
2. No previews ("Let me first...")
3. No self-narration ("I found that...")
4. No confirmation-seeking ("Shall I proceed?")
5. Code output preferred over prose descriptions
6. One-sentence answers for simple questions

## Multi-platform

| File | Platform |
|---|---|
| `platforms/claude-code/SKILL.md` | Claude Code (via `/token-saver`) |
| `platforms/cursor/.cursorrules` | Cursor (auto-loaded) |
| `platforms/copilot/copilot-instructions.md` | GitHub Copilot (`.github/` dir) |
| `platforms/system-prompt.md` | Any LLM — paste into custom instructions |

## Intensity levels

| File | Token cut | Personality |
|---|---|---|
| `intensities/mild.md` | ~30% | Skips summaries, keeps tone |
| `intensities/standard.md` | ~50% | Cuts narration, direct answers |
| `intensities/aggressive.md` | ~65% | Minimum viable output |

## Inspired by

- [caveman](https://github.com/JuliusBrussee/caveman) — the original. 90k stars.

## License

MIT
