package EjercicioAPI.feature;
import com.intuit.karate.junit5.Karate;

public class Runners {
    @Karate.Test
    Karate testLogin() {
        return Karate.run("login").relativeTo(getClass());
    }
    @Karate.Test
    Karate testRegistro() {
        return Karate.run("registro").relativeTo(getClass());
    }
}
