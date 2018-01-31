import java.util.function.*;

public interface Tree<Elm> {
    <Elm2> Tree<Elm2> map(Function<Elm,Elm2> f);
}