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
