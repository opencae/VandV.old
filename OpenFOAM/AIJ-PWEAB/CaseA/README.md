# AIJ-PWEAB/CaseA
## OpenFOAMによる市街地風環境予測のための流体数値解析ガイドブックにおける2:1:1角柱周辺流れのベンチマークテストケース(Case A)の再現

- 作成: 今野 雅 <masashi.imano@gmail.com>
- 実行OpenFOAMバージョン: 4.0, 4.1

### 概要
市街地風環境予測のための流体数値解析ガイドブック -ガイドラインと検証用
データベース-[J1]に掲載されている，2:1:1角柱周辺流れのベンチマークテス
トケース(Case A)をOpenFOAMを用いて解析し，風洞実験値と比較する．

### 必要なソフトウェア
- [Gnuplot](http://www.gnuplot.info/) 風洞実験結果との比較プロットを行う際に必要．
- [convert](https://www.imagemagick.org/script/convert.php) EPS形式のプロットファイルをPDF形式に変換するのに必要．

### 自動実行

各処理を自動実行するには，以下のようにして自動実行スクリプトを実行する．

1. 前処理(格子生成および初期値場の用意)
 ```
./Allrun.pre
```
1. 解析実行
```
./Allrun.solve
```
1. 後処理(解析結果のサンプリング)
```
./Allrun.post
```
1. 風洞実験値との比較プロット
```
./Allrun.plot
```

### 全自動実行

上記の自動実行スクリプトを全て順番に実行するには以下のようにする．

```
./Allrun
```

### 手動実行

#### 格子の生成

##### 不等間隔構造格子の生成

本ケースの格子間隔はガイドブック[J1]で定義されている通り，不等間隔であり，等比級数でも無いので，OpenFOAMの格子生成ユーティリティblockMeshで作成するのは難しい．
そこで，ここでは，格子界面の座標値を定義したファイルを読んで，格子データを直接出力するPythonスクリプトmakeStructuredGridMesh.pyを用いて格子を生成する．

```
python makeStructuredGridMesh.py
```

なお，格子界面の座標値定義ファイルx.dat,y.dat,zdatは，以下のように座標値を一行づつ記述したファイルである．

```
-0.44
-0.376
-0.312
(中略)
1.24
```

##### 格子から角柱領域の除去

格子から角柱領域を除去するには以下のようにする．

###### 角柱内の格子番号リストの出力

まず，角柱の三角メッシュデータをconstant/triSurface/building.stlとして，角柱内の格子番号リスト(cell Set)をbuidingという名前で出力する．

```
insideCells constant/triSurface/building.stl building
```

なお，cell Setはconstant/polyMesh/sets/building に出力される．

###### 角柱外の格子番号リストの出力

角柱外の格子番号リスト(角柱内格子番号リストの補集合)を得るため，system/topoSetDict で以下のように定義する．

```
actions
(
    {
        name    building;
        type    cellSet;
        action  invert;
    }
);
```

topoSetを実行して，角柱外の格子番号リストを出力する．

```
topoSet
```

なお，constant/polyMesh/sets/building は上書きされる．

###### 角柱外の領域のみの格子を生成

subsetMeshを用いて，角柱外の格子番号リストbuildingのみからなる格子を生成する．

```
subsetMesh building -overwrite
```

###### 境界条件の修正

subsetmeshによって，角柱表面からなる新しいパッチが生成されるが，このパッチの境界条件型をwall(壁)にする必要がある．
また，makeStructuredGridMesh.pyは，解析領域の6面体における6つパッチ
```x_, _x, y_, _y, z_, _z```の境界型をpatchとして，格子データを生成するので，z_(地表面)のパッチの境界条件型もwall(壁)にする必要がある．
そこで，system/changeDictionaryで以下のように，これらのパッチの境界条件型をwallに修正するよう定義する．

```
boundary
{
    z_
    {
        type            wall;
    }
    oldInternalFaces
    {
        type            wall;
    }
}
```

その上で，changeDictionaryを実行する．

```
changeDictionary
```

#### 初期値場の用意

orig0ディレクトリにある初期値場を，0ディレクトリにコピーする．

```
cp -a orig0 0
```

ちなみに，最初から0ディレクトリとして用意しないのは，subsetMeshを実行した時に，0ディレクトリ内の場ファイルが書き変えられてしまうためである．

#### 解析実行

解析ソルバのsimpleFoamを実行する．

```
simpleFoam >& log.simpleFoam &
```

ソルバーのログはファイルlog.simpleFoamに出力されるが，tailコマンドを用いると内容をトレースできる．

```
tail -f log.simpleFoam
```

tailコマンドはCtrl-C(コントールキーとCキーを一緒に押す)で終了させることができる．
なお，これによって解析ソルバーsimpleFoamが停止することはない．
逆に，解析ソルバーsimpleFoamを途中で停止させるには，以下のようにする．

```
fg
Ctrl-C(コントールキーとCキーを一緒に押す)
```

#### 残差のプロット

残差をプロットするには以下のようにする．

```
foamMonitor -l postProcessing/residuals/0/residuals.dat
```

なお，上記は，解析途中でも解析後でも実行可能であり，解析途中ではプロット図が更新される．

#### 解析結果のサンプリング

解析結果のサンプリングを行うには，以下のようにする．

```
postProcess -func sample -latestTime
```

なお，サンプリング結果は，postProcessing/sample/1000 のディレクトリにテキスト形式で出力される．

#### 解析結果と風洞実験結果の比較プロット

主流方向の風速Uxについて，解析結果と風洞実験結果の比較プロットを行うには，以下のようにする．

```
gnuplot plot/profileU.gp
```

同様に，乱流エネルギkについてプロットするには，以下のようにする．

```
gnuplot plot/profilek.gp
```

残差についても，以下でプロットできる．

```
gnuplot plot/residual.gp
```

プロットファイルprotfileU.eps, protfilek.eps, residual.epsはEPS形式で
作成されるので，evinceなどのEPS形式が閲覧できるビューワーで閲覧する．

```
evince *.eps
```

なお，画像形式変換ユーティリティのconvertを用いて，以下で複数のepsファイルをpdfファイルに変換することも可能である．

```
convert -density 300 profileU.eps profilek.eps residual.eps CaseA.pdf
```

evinceなどのPDF形式が閲覧できるビューワーで閲覧する．

```
evince *.eps
```

#### ケースの初期化

解析結果，ログファイル，サンプリング結果，プロットファイルなどを全て消去して，ケースの初期化を行うには以下のようにする．

```
./Allclean
```

### 参考文献
- [J1] 市街地風環境予測のための流体数値解析ガイドブック −ガイドラインと検証用データベース− URL: http://www.aij.or.jp/jpn/publish/cfdguide/index.htm
- [J2] 今野 雅, 大嶋拓也, 挾間貴雅, 柴田貴裕, 小縣信也: オープンソースCFDツールキットOpenFOAMを用いた市街地風環境予測, 第24回数値流体力学シンポジウム講演要旨集, D5-6, Dec., 2010, URL: http://www2.nagare.or.jp/cfd/cfd24/paper/D5-6.pdf

## Reproduction of benchmark test case A formulated in AIJ guidelines for practical applications of CFD to pedestrian wind environment around buildings

- Creator: Masashi IMANO <masashi.imano@gmail.com>
- Supported OpenFOAM version: 4.0, 4.1

### Prerequisites

Gnuplot utility are required in order to run the case.

###  What is this?

This case solves benchmark test case A defined in AIJ guidelines for practical applications of CFD to pedestrian wind environment around buildings [E1] following the benchmark procedure.

### Running the case
In order to run the case:

1. Type ./Allrun. This script will automatically make mesh, perform CFD calculation.
1. After the run, you will find profileU.eps and profilek.eps which compare the OpenFOAM results with those of a wind tunnel test [E2].
1. Type ./Allclean to clean up the case directory and reset to the initial state.

### References
- [E1] Architectural Institute of Japan, Guidebook for Practical Applications of CFD to Pedestrian Wind Environment around Buildings, 2007. URL: http://www.aij.or.jp/jpn/publish/cfdguide/index_e.htm
- [E2] Mochida, A., Tominaga, Y., Murakami, S., Yoshie, R., Ishihara, T., Ooka, R., 2002. Comparison of various k-epsilon model and DSM applied to flow around a high-rise building - report on AIJ cooperative project for CFD prediction of wind environment -, Wind & Structures 5, No.2-4, 227-244.  URL: http://www.aij.or.jp/jpn/publish/cfdguide/R02_6.pdf

## Disclaimer:
OPENFOAM(R) is a registered trade mark of ESI Group,
the producer of the OpenFOAM software and owner of the OPENFOAM(R) trade marks.
This offering is not approved or endorsed by ESI Group.
