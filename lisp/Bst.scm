;; branch, leaf を作る
(define (newbranch l v r) (list 'Br v l r))
(define (newleaf) (list 'Lf'))

;; データの種類(branch or leaf)を調べる
(define (leaf? t)
    (eq? (car t) 'Lf))
(define (branch? t)
    (eq? (car t) 'Br))

;; データの要素を取り出す
(define (branch-value t) (cadr t))
(define (branch-left t) (caddr t))
(define (branch-right t) (cadddr t))

;; 探索
(define (find t n)
    (cond
        ((leaf? t) #f)
        ((branch? t)
            (let ((l (branch-left t))
                  (v (branch-value t))
                  (r (branch-right t)))
                (cond
                    ((= n v) #t)
                    ((< n v) (find l n))
                    (else (find r n)))))))

;; 挿入
(define (insert t n)
    (cond
        ((leaf? t)
         (newbranch (newleaf) n (newleaf)))
        ((branch? t)
         (let ((l (branch-left t))
               (v (branch-value t))
               (r (branch-right t)))
            (cond
                ((= n v) t)
                ((< n v) (newbranch (insert l n) v r))
                else (newbranch l v (insert r n)))))))

;; 削除
(define (min t)
  (cond
   ((leaf? t) (error "Invalid argument" t))
   ((and (branch? t)
         (leaf? (branch-left t)))
    (branch-value t))
   (else (min (branch-left t)))))

(define (delete t n)
  (cond
   ((leaf? t) t)
   ((branch? t)
    (let ((l (branch-left t))
          (v (branch-value t))
          (r (branch-right t)))
      (cond
       ((= n v)
        (cond
         ((and (leaf? l) (leaf? r)) (newleaf))
         ((and (branch? l) (leaf? r)) l)
         ((and (leaf? l) (branch? r)) r)
         (else
          (let ((m (min r)))
            (newbranch l m (delete r m))))))
       ((< n v) (newbranch (delete l n) v r))
       (else (newbranch l v (delete r n))))))))