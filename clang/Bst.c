// include 等は省略

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

// branch, leaf 作成用補助関数
struct tree *newbranch(struct tree *left, int value, struct tree *right){
    struct tree *n = (struct tree *)malloc(sizeof(struct tree));
    n->tag = BRANCH;
    n->dat.br.left = left;
    n->dat.br.value = value;
    n->dat.br.right = right;
    return n;
}

struct tree *newleaf(){
    struct tree *n = (struct tree *)malloc(sizeof(struct tree));
    n->tag = LEAF;
    return n;
}

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

// 挿入
struct tree *insert(struct tree *t, int n) {
  if (t->tag == LEAF) {
    return newbranch(newleaf(), n, newleaf());
  } else /* t->tag == BRANCH */ {
    struct branch b = t->dat.br;
    if (n == b.value) {
      return t;
    } else if (n < b.value) {
      return newbranch(insert(b.left, n), b.value, b.right);
    } else /* n > b.value */ {
      return newbranch(b.right, b.value, insert(b.right, n));
    }
  }
}

// 削除
int min(struct tree *t) {
  assert(t->tag == BRANCH);
  struct branch b = t->dat.br;
  if (b.left->tag == LEAF) {
    return b.value;
  } else {
    return min(b.left);
  }
}

struct tree *delete(struct tree *t, int n) {
  if (t->tag == LEAF) {
    return t;
  } else /* t->tag == BRANCH */ {
    struct branch b = t->dat.br;
    if (n == b.value) {
      if (b.left->tag == LEAF) {
        if (b.right->tag == LEAF) {
          return newleaf();
        } else /* b.right->tag == BRANCH*/ {
          return b.right;
        }
      } else /* b.left->tag == BRANCH*/ {
        if (b.right->tag == LEAF) {
          return b.left;
        } else /* b.right->tag == BRANCH*/ {
          int m = min(b.right);
          struct tree *newRight = delete(b.right, m);
          return newbranch(b.left, m, newRight);
        }
      }
    } else if (n < b.value) {
      struct tree *newLeft = delete(b.left, n);
      return newbranch(newLeft, b.value, b.right);
    } else /* n > b.value */ {
      struct tree *newRight = delete(b.right, n);
      return newbranch(b.left, b.value, newRight);
    }
  }
}