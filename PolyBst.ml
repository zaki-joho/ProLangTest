(* 多相的二分探索木 *)
type 'elm tree =
    Lf       (* Leaf *)
  | Br of {  (* Branch *)
      left:  'elm tree;
      value: 'elm;
      right: 'elm tree;
    }

let rec find cmp t n =
  (* cmp(x,y) は x<y なら負整数, x=y なら 0, x>y なら正整数を返す関数 *)
  match t with
    Lf -> false
  | Br {left=l; value=v; right=r} ->
     if cmp n v = 0 then true
     else if cmp n v < 0 then find cmp l n
     else (* n > v *) find cmp r n

let rec insert cmp t n =
  match t with
    Lf -> Br {left=Lf; value=n; right=Lf}
  | Br {left=l; value=v; right=r} ->
     if cmp n v = 0 then t
     else if cmp n v < 0 then Br {left=insert cmp l n; value=v; right=r}
     else (* n > v *) Br {left=l; value=v; right=insert cmp r n}

let rec min t =
  match t with
    Lf -> invalid_arg "Input can't be a leaf!"
  | Br {left=Lf; value=v; right=_} -> v
  | Br {left=l; value=_; right=_} -> min l

let rec delete cmp t n =
  match t with
    Lf -> t
  | Br {left=l; value=v; right=r} ->
     if cmp n v = 0 then
       match l, r with
	 Lf, Lf -> Lf
       | Br _, Lf -> l
       | Lf, Br _ -> r
       | Br _, Br _ ->
	  let m = min r in
	  Br {left=l; value=m; right=delete cmp r m}
     else if cmp n v < 0 then Br {left=delete cmp l n; value=v; right=r}
     else (* n > v *) Br {left=l; value=v; right=delete cmp r n}

(* 型は
val find : ('a -> 'b -> int) -> 'b tree -> 'a -> bool = <fun>
val insert : ('a -> 'a -> int) -> 'a tree -> 'a -> 'a tree = <fun>
val delete : ('a -> 'a -> int) -> 'a tree -> 'a -> 'a tree = <fun>
*)

(* elm = int の場合
let t1 = Br {left = Lf; value = 10; right = Lf}
let t2 = Br {left = Lf; value = 25; right = Lf}
let t3 = Br {left = t1; value = 15; right = t2}

let test1 = find (fun x y -> x - y) t3 30
*)

(* elm = string の場合
let t11 = Br {left = Lf; value = "I"; right = Lf}
let t12 = Br {left = Lf; value = "love"; right = Lf}
let t13 = Br {left = t11; value = "OCaml"; right = t12}

let test11 = find String.compare t13 "so?"
*)