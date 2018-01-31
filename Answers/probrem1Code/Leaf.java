import java.util.function.Function;

public class Leaf<Elm> implements Tree<Elm> {
    public Leaf() {
    }

    public <Elm2> Tree<Elm2> map(Function<Elm, Elm2> f) {
        return new Leaf<Elm2>();
    }
}