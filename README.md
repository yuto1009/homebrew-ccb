![thumbnail](./thumbnail.png)

# ccb — Claude Code Bookmark

**English** | [日本語](README.ja.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey.svg)]()
[![Dependencies](https://img.shields.io/badge/dependencies-none-brightgreen.svg)]()

Bookmark the prompts that worked.

`ccb` digs through your [Claude Code](https://claude.com/claude-code) session history, shows you the prompts you've written in the current project, and lets you save the good ones — so your best prompts stop disappearing into log files.

```
 ccb pick — select prompts to bookmark  (20 items, 2 checked)
 [x] Fix the flaky auth test and explain the root cause of the failure
 [ ] Refactor the session parser to stream large JSONL files
 [x] Write a migration script that backfills the new status column
 [ ] Add error handling to the webhook endpoint and retry on 5xx
─────────────────────────────────────────────────────────────────────
 Fix the flaky auth test and explain the root cause of the failure

 ↑/↓/j/k: move  Space: toggle  Enter: save  q: quit
```

## Why

A great prompt is a reusable asset — but once a Claude Code session ends, it's buried in JSONL files you'll never open. `ccb` runs in a separate shell session, reads that history **without touching your running Claude Code context**, and turns your best prompts into a curated, greppable collection.

- **Zero dependencies** — a single Python file using only the standard library
- **Read-only & safe** — never writes to Claude Code's data; it only reads session history
- **Per-project** — reads and stores bookmarks scoped to the directory you run it in
- **Plain JSONL storage** — bookmarks live in `~/.claude/ccb/`, ready for `grep`, `jq`, or `fzf`
- **CJK-aware TUI** — East Asian wide characters are measured and wrapped correctly

## Installation

### Homebrew

```sh
brew tap yuto1009/ccb
brew install ccb
```

### Manual

```sh
git clone https://github.com/yuto1009/homebrew-ccb.git
ln -s "$(pwd)/homebrew-ccb/ccb" /usr/local/bin/ccb
```

Requires Python 3.8+ (the `python3` preinstalled on macOS works).

## Usage

Run it inside a project where you use Claude Code.

### `ccb pick` — bookmark prompts from history

Shows the 20 most recent unique user prompts from this directory's Claude Code history. Check the ones you want and press Enter to save.

```sh
cd ~/your-project
ccb pick
```

### `ccb list` — browse and remove bookmarks

Shows this directory's bookmarks, newest first. Check items and press Enter to remove them (with a y/n confirmation).

```sh
ccb list
```

### Key bindings

| Key | Action |
| --- | --- |
| `↑` `↓` / `k` `j` | Move cursor |
| `Space` | Toggle check |
| `Enter` | Confirm (pick: save / list: delete, with y/n confirmation) |
| `q` / `Esc` | Quit without changes |

The bottom pane always previews the full text of the highlighted prompt.

## How it works

| Purpose | Path |
| --- | --- |
| Reads (Claude Code history) | `~/.claude/projects/<encoded-cwd>/*.jsonl` |
| Writes (your bookmarks) | `~/.claude/ccb/<encoded-cwd>.jsonl` |

`<encoded-cwd>` follows Claude Code's own naming convention (non-alphanumeric characters replaced with `-`), so `ccb` always operates on the history of the directory you run it from.

Bookmarks are one JSON record per line:

```json
{"text": "the prompt text", "bookmarked_at": "2026-07-16T12:00:00+09:00", "cwd": "/Users/you/your-project"}
```

Extraction rules:

- Only real user prompts — tool results, system metadata, slash-command internals, and interruption markers are filtered out
- Duplicate texts are collapsed into one entry, newest first
- Already-bookmarked prompts are never saved twice

## Contributing

Issues and pull requests are welcome!

## License

[MIT](LICENSE)
