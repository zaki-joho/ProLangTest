# 語句説明とか

## 再帰と繰り返し

## モジュールシステム
名前空間
分割コンパイル

``` module.ml
module Sample =
    struct
      let inc x = x + 1;
    end;;
(* module Sample : sig val inc : int -> int end *)
Sample.inc 100;;
(* int = 101 *)
```

## 多相性

## 高階関数

## 構文論
前置・中置・後置演算子
ミックスフィックス演算子(ex.三項演算子)

右結合・左結号

強い型付言語: 一部の実行時エラーを実行前にすべて検知できる型システムを持つ