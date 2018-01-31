import java.util.function.Function;

public class Branch<Elm> implements Tree<Elm> {
    private Tree<Elm> left, right;
    private Elm v;

    public Branch(Tree<Elm> left, Elm v, Tree<Elm> right) {
        this.left = left;
        this.v = v;
        this.right = right;
    }

    public <Elm2> Tree<Elm2> map(Function<Elm, Elm2> f) {
        Tree<Elm2> newLeft = left.map(f);
        Tree<Elm2> newRight = right.map(f);
        Elm2 newVal = f.apply(v);
        return new Branch<Elm2>(newLeft, newVal, newRight);
    }
}