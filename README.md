# hackday2017
# 決定
- 足踏みシステムを2人分作る
- User間のやりとり
 - UserAが押してUserBが走ったあとUserBがUserAに対して押せるようになるか（dashButtonでやりあい）
- 流す音
 - 現在の歩数（20区切りで、上限はとりあえず100）
 - text2speech(拡張性を考慮して)
 - 開始音終了音(startとgoal)
 
#分担
 - サーバ担当(mac)(橋本)
  - flag管理(2)
 - サーバ担当(ラズパイ)
  - dashButton連携(2)(橋本)
  - 足踏みセンサー(川崎,田中)
   - 作成(3)
   - 連携(5)
  - 音声出力(2)
 - 音声作成(sayコマンド,etc)(1)
 - 資料作り(5)3人で！
 
#流れ
```
 dashButtonA -> razpiA
 razpiA -> mac
 if flagA=true
  mac -> razpiA : ok
  mac -> mac : changeFlag
  mac -> razpiB : dash
  razpiB -> speakerB : sound
  UserB -> runnningSensorB : running
  runnningSensorB -> razpiB : hosuuCount
  while do
    razpiBが状況に応じてspeakerに歩数を投げて
    その都度runnningSensorB
  done
  razpiB -> mac : changeFlag
else
 mac -> razpiA : ng
 ```

# stateの流れ
```
---------
3状態のflagのパターン

音声を流すタイミングのフラグ
押せるかどうかの判定のフラグ

flag='A' : Aさんがボタンを押せるという意味

init: flag='A' : server

userA->dashButtonA : click
dashButtonA -> razPiA
razPiA -> server : click ok?

if flag='A' : serverが判定 | getClickab
  server -> razPiA : 200 ok
  server -> server : flag='B'
else
  server -> razPiA : 200 ng
  razPiA -> userA : だめだよ by speaker

while do
  razPiB -> server : request/s
  if flag='B'
   razPiB -> speakerB : sound
   flag='null'
   userB -> userB : running
   while do
    razPiB -> UserB : runningの監視
   done
   flag='B'
  else
done

---------
```
