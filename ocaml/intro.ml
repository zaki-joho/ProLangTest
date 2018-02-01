(* 通常の let 宣言*)
let x = 1 + 2 * 3;;
(* val x : int = 7 *)

(* 型指定 *)
let x : int = 1 + 2 * 3;;
(* val x : int = 7 *)

(* 関数宣言
let <関数名> (param1 param2 ...) = expression
*)
let average(x,y) = (x + y) / 2;;
(* val average : int * int -> int = <fun> *)

(* 再帰関数 *)
let rec fact n =
    if n = 1 then 1 else n * fact ( n - 1);;
(* val fact : int -> int = <fun> *)

(* 条件分岐 
if <condition> then <expr1> else <expr2>
*)
let abs n =
    if n < 0 then -n else n;;
(* val abs : int -> int = <fun> *)

(* 局所定義 
let <val> = <expr1> in <expr2>
expr2 の値が返される
*)
let n = 5 * 2 int n + n;;
(*  - : int = 20 *)

(* レコード *)
type point = {x: int; y: int;};;
(* 値作成 型定義と微妙に表記が異なる *)
let origin = {x = 0; y = 0};;
(* val origin : point = {x = 0; y = 0} *)

(* ヴァリアント *)
type furikake = Shake | Katsuo | Nori;;
(* match 式 *)
let isVeggie f =
    match f with
      Shake -> false
    | Katsuo -> false
    | Nori -> true
    ;;
(* val isVeggie : furikake -> bool = <fun> *)
(* ワイルドカード・パターン 
match n with
    2 | 3 | 5 | 7 | 11 | 13 | 17 | 19 -> true
  | _ -> false
*)

(* mutable record *)
type mutable_point = {mutable x : int; mutable y : int;};;
(* 値作成 *)
let m_origin = {x = 0; y = 0};;
(* val m_origin : mutable_point = {x = 0; y = 0}*)
(* 値更新 *)
m_origin.x <- 2;;
(* unit = () 計算効果 *)

