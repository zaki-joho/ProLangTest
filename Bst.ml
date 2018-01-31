(* 資料の二分木を実装 *)
type tree =
    Lf
    | Br of {
        left: tree;
        value;
        right: tree;
    }

(* 具体的な二分木は以下のように作成 
let t1 = Br {left = Lf; value = 10; right = Lf}
let t2 = Br {left = Lf; value = 25; right = Lf}
let tr = Br {left = t1; value = 10; right = t2}
*)

(* 探索 *)
let rec find(t, n) =
  match t with
    Lf -> false
  | Br {left=l; value=v; right=r} ->
     if n = v then true
     else if n < v then find(l, n)
     else (* n > v *)   find(r, n)

(* 挿入 *)
let rec insert(t, n) =
  match t with
    Lf -> Br {left=Lf; value=n; right=Lf}
  | Br {left=l; value=v; right=r} ->
     if n = v then t
     else if n < v then Br {left=insert(l, n); value=v; right=r}
     else (* n > v *)   Br {left=l;            value=v; right=insert(r, n)}

(* 削除 *)
let rec delete(t, n) =
  match t with
    Lf -> t
  | Br {left=l; value=v; right=r} ->
     if n = v then
       match l, r with
         Lf,   Lf   -> Lf
       | Br _, Lf   -> l
       | Lf,   Br _ -> r
       | Br _, Br _ ->
          let m = min r in
          Br {left=l; value=m; right=delete(r, m)}
     else if n < v then Br {left=delete(l, n); value=v; right=r}
     else (* n > v *)   Br {left=l;            value=v; right=delete(r, n)}

