# nixos-config

Neovimとtmuxの設定は `~/dev/setup/config` から取り込んだ `dotfiles/` を
Home Managerで配置します。以後のNixOS向け変更はこのリポジトリで管理します。
fishをログインシェルとして使用します。

NeovimのLua LSPはNixの `lua-language-server` を使用します。
追加のLSPもNixで導入し、`dotfiles/nvim/lua/plugins/lsp.lua` で有効化してください。

lazy.nvimのプラグインは初回起動時に取得します。更新可能なlockfileは
`~/.local/share/nvim/lazy-lock.json` に初回のみ配置します。
更新を保存する場合は、このファイルを `dotfiles/nvim/lazy-lock.json` に取り込みます。

既存の設定ファイルはHome Managerへの移行時に `.before-home-manager` 付きで
バックアップします。同名のバックアップが既にある場合は、先に移動してください。

## 構成

- `hosts/v3/`: V3固有の設定、ハードウェア設定、ディスク構成、stateVersion
- `modules/nixos/`: システム、ネットワーク、デスクトップ、開発環境などのNixOS設定
- `home/nop/`: ユーザー情報、アプリ一覧、Fish・tmux・NeovimのHome Manager設定
- `dotfiles/`: Home Managerで配置する設定ファイル
- `pkgs/`: 独自パッケージ定義

機種ごとに `hosts/v3/`、`hosts/desktop/` のように分けます。
現在の `nixosConfigurations.nixos` は `hosts/v3/` を読み込みます。
Desktopを追加する場合は、その実機で生成した `hardware-configuration.nix` と
専用の `default.nix` を `hosts/desktop/` に置き、flakeの構成を追加します。
ディスクUUID・マウント設定は機種ごとに指定し、V3の値を流用しないでください。
共通設定は `modules/nixos/` を読み込みます。

設定は `flake.nix` から読み込みます。再構築コマンドは従来どおりです。

```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

## 開発環境とdirenv

Fishでdirenv・nix-direnvを利用します。プロジェクトの `.envrc` を
`direnv allow` で承認すると、移動時に開発環境が読み込まれます。
環境はnix-direnvがキャッシュします。

RSJ用のTeX・Ghostscript・Poppler・Pythonはシステム全体ではなく、
`devshells/tex.nix` で管理します。手動で使う場合:

```bash
cd ~/dev/lab/RSJ
nix develop ~/dev/nixos-config#tex
make check
```

再構築後、新しいFishセッションで自動読み込みを設定する場合:

```bash
cd ~/dev/lab/RSJ
# 既存の .envrc がある場合は上書きせず、次の行を追記してください。
echo 'use flake "$HOME/dev/nixos-config#tex"' >> .envrc
direnv allow
```

`.direnv/` はプロジェクトのGit除外設定に追加してください。
Node・Rustなど既存の開発ツールは引き続きシステム全体で利用できます。

## ROS 2 Humble

`nix-ros-overlay` のHumble desktop開発環境を使用します。
システムとは別に、overlay側のnixpkgsでROSの依存関係を管理します。

```bash
nix develop /etc/nixos#ros2-humble
echo "$ROS_DISTRO"
ros2 --help
colcon --help
```

開発シェルはBashです。終了するには `exit` を実行します。
システムの再構築後はROS用のバイナリキャッシュも利用できます。
キャッシュにないパッケージはソースからビルドされる場合があります。

## Autodesk Inventor

[上流のNixOS手順](https://github.com/Harvi654/Autodesk-Inventor-for-Linux/blob/main/docs/nixos.md)
に従い、Inventor Professional 2027 English（2027.1更新・Content Center付き）を
`modules/nixos/inventor.nix` で有効化します。専用Wine、FUSE、デスクトップ項目、
Autodeskサインインのコールバックは上流モジュールが設定します。
Inventor側のnixpkgsはシステム側に追従させず、上流の固定値を使用します。

Autodeskから取得した以下の英語版メディアを、再構築前に登録してください。
日本語版のWebインストーラーでは代用できません。

```bash
nix-store --add-fixed sha256 ~/Downloads/Inventor_Professional_2027_English_Win_64bit_db_002_002.7z
nix-store --add-fixed sha256 ~/Downloads/Inventor_2027.1_Update.exe
cd ~/dev/nixos-config
nix flake lock
git add flake.lock
git commit -m "chore(deps): lock Inventor input"
sudo nixos-rebuild switch --flake /etc/nixos#nixos
inventor-2027
```

今回の追加時はネットワーク制限でlockfileを生成できなかったため、入力URL自体を
コミットに固定しています。初回に上記の `nix flake lock` を実行してください。
更新は入力URLのコミットを変更して `nix flake update inventor` を実行します。
初回はWineのビルドに時間とディスク容量が必要です。利用にはAutodeskのアカウントと
ライセンスが必要です。AutodeskメディアやInventorを含むビルド結果・システムclosureを
公開バイナリキャッシュにアップロードしないでください。

## Tern

`pkgs/tern.nix` で公式Linuxバイナリをパッケージ化し、Home Managerで導入します。
ターミナルでは `tern`、アプリ一覧では「Tern」から起動できます。
配布ファイルの取得にはStencilへのログインが必要です。ブラウザで取得後、
再構築前に一度だけNixストアへ登録してください。

```bash
nix-store --add-fixed sha256 ~/Downloads/Tern-0.9.14-linux-x86_64.tar.gz
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

登録後のビルドはDownloadsを参照せず、固定したSHA-256で内容を検証します。
ストアのGCで削除された場合は再登録してください。
更新時は `pkgs/tern.nix` の `version`、案内URL、`hash` とこの登録コマンドを更新します。

## ChatGPT / Claude

ChatGPTは `llm-agents` が参照する新しいnixpkgsの公式アプリパッケージ `chatgpt`、Claudeは
`llm-agents` の `claude-desktop` で公式Linux版を導入します。
アプリ一覧の「ChatGPT」「Claude」、または `chatgpt` / `claude-desktop` で起動します。
Claudeの更新は `nix flake update llm-agents` を実行し、再構築してください。
Claude Cowork用のQEMU・仮想マシン環境はこの設定には含めていません。
システムのnixpkgs 26.05ではChatGPTがmacOS専用、WinBoatのElectronがサポート終了済みのため、
この2つは `flake.lock` で固定された `llm-agents` 側のnixpkgsから導入します。
