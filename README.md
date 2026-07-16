# ccb — Claude Code Bookmark

Claude Code（CLI）で打ったプロンプトのうち「良かったもの」をブックマーク保存する CLI ツールです。
Claude 起動中とは別のシェルセッションで動かすため、コンテキストを一切汚しません。

- Claude Code のセッション履歴（`~/.claude/projects/`）を **読み取り専用** で参照します（本体には何も書き込みません）
- ブックマークは `~/.claude/ccb/` 配下に **cwd 別の JSONL** で保存され、後から grep 等で扱えます
- 依存は Python 標準ライブラリのみ（`curses`）。追加パッケージ不要です

## インストール

### Homebrew

```sh
brew tap yuto1009/ccb
brew install ccb
```

> 初回リリース（タグ）前に試す場合は `brew install --HEAD ccb` を使ってください。

### 手動インストール

```sh
git clone https://github.com/yuto1009/homebrew-ccb.git
ln -s "$(pwd)/homebrew-ccb/ccb" /usr/local/bin/ccb
```

macOS 標準の `python3` で動作します。

## 使い方

Claude Code を使っているプロジェクトのディレクトリで実行します。

### `ccb pick` — 履歴からプロンプトを選んで保存

そのディレクトリの Claude Code 履歴から抽出したユーザープロンプト
（重複除去後の直近 20 件）を一覧表示し、選んだものをブックマークに保存します。

```sh
cd ~/your-project
ccb pick
```

### `ccb list` — ブックマークの一覧・削除

そのディレクトリで保存したブックマークを新しい順に一覧表示します。
チェックした項目を Enter で確定すると、確認（y/n）のうえブックマークから完全削除します。

```sh
ccb list
```

### キー操作（共通）

| キー | 動作 |
| --- | --- |
| `↑` `↓` / `k` `j` | カーソル移動 |
| `Space` | チェックの切り替え |
| `Enter` | 確定（pick: 保存 / list: 削除。削除時は y/n 確認あり） |
| `q` / `Esc` | 何もせず終了 |

画面下部にはカーソル位置のプロンプト全文のプレビューが表示されます。

## データの場所

| 用途 | パス |
| --- | --- |
| 読み取り元（Claude Code 履歴） | `~/.claude/projects/<encoded-cwd>/*.jsonl` |
| ブックマーク保存先 | `~/.claude/ccb/<encoded-cwd>.jsonl` |

`<encoded-cwd>` は Claude Code の命名規則（英数字以外を `-` に置換）に合わせています。
ブックマークは 1 行 1 レコードの JSONL です:

```json
{"text": "プロンプト本文", "bookmarked_at": "2026-07-16T12:00:00+09:00", "cwd": "/Users/you/your-project"}
```

## 抽出ルール

- ユーザープロンプトのみを対象（ツール実行結果、システムメタ、slash コマンドのメタ、割り込みメッセージ等は除外）
- 同一テキストは 1 件に集約し、新しい順に並べる
- 既にブックマーク済みのプロンプトは重複保存しない

## リリース手順（メンテナ向け）

1. `ccb` 内の `VERSION` を更新してコミット
2. タグを打って push: `git tag v0.1.0 && git push origin main --tags`
3. tarball の sha256 を計算:
   ```sh
   curl -sL https://github.com/yuto1009/homebrew-ccb/archive/refs/tags/v0.1.0.tar.gz | shasum -a 256
   ```
4. `Formula/ccb.rb` の `url`（バージョン）と `sha256` を更新してコミット・push

## ライセンス

[MIT](LICENSE)
