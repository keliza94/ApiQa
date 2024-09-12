package EjercicioAPI;
import static org.junit.jupiter.api.Assertions.*;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

public class TestRunners {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:EjercicioAPI")
                .parallel(2);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
}
}
