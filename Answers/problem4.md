# 問4の解答

``` tree.c
// tree の定義
struct tree{
    enum nkind { LEAF, BRANCH} tag;
    union{
        struct leaf {int dummy} lf;
        struct branch{
            struct tree *left;
            int value;
            struct tree *right;
        } br;
    } dat;
};

// 探索
bool find(struct tree *t, int n){
    if(t->tag == LEAF){
        return false;
    }
    else{
        struct branch b = t->dat.br;
        if(n == b.value){
            return true;
        }
        else if(n<b.value){
            return find(b.left, n);
        }
        else{
            return find(b.right, n);
        }
    }
}
```