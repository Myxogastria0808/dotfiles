## Nix

自動的に生成、挿入される宣言不要の5つのパラメータ

```nix
{ lib, config, options, pkgs, ...  }: {
  #do something
}
```

1. lib
  - nixpkgsに含まれる組み込み関数ライブラリで、Nix式を操作するための実用的な関数を多数提供する。
  - 詳細: https://nixos.org/manual/nixpkgs/stable/#id-1.4

2. config
  - 現在の環境のすべてのオプションのセット

3. options
  - 現在の環境内のすべてのモジュールで定義されているすべてのオプションのセット。

4. pkgs
  - すべての nixpkgs といくつかの関連するユーティリティ関数を含むコレクション

## /etc/nixos

このディレクトリのルートに以下の3つのファイルを配置する

1. flake.nix
 - `sudo nixos-rebuild switch`実行時に認識され、デプロイされるフレークのエンドポイント
 - flake.nixが`/etc/nixos`以外にあるときは、`sudo nixos-rebuild switch --flake /path/to/your/flake#your-hostname`で実行可能
   - 例 カレントディレクトリに`flake.nix`がある場合 
   - `sudo nixos-rebuild switch --flake .#nixos`

2. configuration.nix
 - `flake.nix`にimportされている以前の構成ファイル

3. hardware-configuration.nix
 - システムのハードウェア構成ファイル

## Flakes機能

Nix pkgs 間の依存関係とプロジェクトのビルド方法を記述する

### Flakesを有効にしていた場合

`sudo nixos-rebuild switch` を実行すると、以下の順でファイルの読み取りを行おうとする。

1. /etc/nixos/flake.nix
2. /etc/nixos/configuration.nix
