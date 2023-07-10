# dotfiles

## 必須環境

## 実行手順
brewのインストール
```
make setup_local
```

アプリケーションのインストール

```
make apps
```

システム環境設定

```
make system_preference
```

## その他設定

- google font
- [karabiner で US 配列対応](https://decoy284.net/karabiner-input-switch/)
- [karabiner で尊師スタイルに対応](https://www.l08084.com/entry/2019/12/22/194228)

## ディレクトリ構造

```
root
├── Makefile                        ・・・コマンド
├── README.md
└── scripts
    ├── install_brew_app.sh         ・・・アプリのインストール
    ├── set_system_preference.sh    ・・・システム環境設定
    └──  setup_local                ・・・初期設定
```
