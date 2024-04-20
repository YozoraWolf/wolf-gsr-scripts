<img src='../flags/MX.svg' width='15' height='10'> [Español](README_ES.MD) | <img src='../flags/US.svg' width='15' height='10'> [English](../README.MD) | <img src='../flags/FR.svg' width='15' height='10'> [Français](README_FR.MD) | <img src='../flags/JP.svg' width='15' height='10'> [日本語](README_JP.MD)


# Wolf's GSR スクリプト

GSR ([gpu-screen-recorder](https://git.dec05eba.com/gpu-screen-recorder/about/))は、WindowsのShadowplayと似た機能を提供する、Linux向けの効果的なスクリーンレコーダーです。

このリポを公開して、皆がこれらのスクリプトを自分のセットアップに使用し、私がビデオを保存する方法に従うことができるようにします。自分の環境で正しく動作させるために、これらを適切に編集する必要があることに注意してください。

# 依存関係

最近 `screen` サポートを追加しましたので、インストールされていない場合はインストールしてください：

```
sudo apt install screen
```

# スクリプト

## gsr-check-sound-change.sh

シンク数が変更されたときに検出し、すべての gpu-screen-recorder プロセスを終了し、現在実行中のスクリーンを再起動します。また、ロックファイルシステムもあり、一度に1つのインスタンスしか実行されません。

このスクリプトは `screen_out.txt` と同じフォルダーにファイルを出力して、何か問題が発生した場合のログを提供します。

## gsr-start-replay.sh

指定されたシンクまたはシンクリスト（`|` で区切られています）で再生を開始します。指定されていない場合はデフォルトのシンクが使用されます。

```
./gsr-start-script シンク名
```
