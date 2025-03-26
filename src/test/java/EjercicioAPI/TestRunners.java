package EjercicioAPI;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestRunners {

    @Test
    void runAllFeaturesTogether() {
        Results results = Runner.path("classpath:features")
                .outputCucumberJson(true)
                .parallel(2); // o 1 si quieres debug paso a paso

        generateReport(results.getReportDir());

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    // Método para generar reportes manualmente
    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(
                new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        for (File file : jsonFiles) {
            jsonPaths.add(file.getAbsolutePath());
        }
        Configuration config = new Configuration(new File("target"), "Karate Test Report");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

    /*
    @Test
    void testcarData() {
        Results results = Runner.path("classpath:features/consulta_marca_modelo_year.feature")
                .outputCucumberJson(true)  // Asegura la generación de reportes JSON
                .parallel(2);

        generateReport(results.getReportDir());

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void testcarIAData() {
        Results results = Runner.path("classpath:features/generar_descripcion_con_ai.feature")
                .outputCucumberJson(true)  // Asegura la generación de reportes JSON
                .parallel(2);

        generateReport(results.getReportDir());

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }


    @Test
    void testsuggestmodelData() {
        Results results = Runner.path("classpath:features/modelo_sugerido.feature")
                .outputCucumberJson(true)  // Asegura la generación de reportes JSON
                .parallel(2);

        generateReport(results.getReportDir());

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void testsuggestversionData() {
        Results results = Runner.path("classpath:features/version_sugerida.feature")
                .outputCucumberJson(true)  // Asegura la generación de reportes JSON
                .parallel(2);

        generateReport(results.getReportDir());

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void testsuggestpriceData() {
        Results results = Runner.path("classpath:features/precio_sugerido.feature")
                .outputCucumberJson(true)  // Asegura la generación de reportes JSON
                .parallel(2);

        generateReport(results.getReportDir());

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    void testsuggestyearData() {
        Results results = Runner.path("classpath:features/year_sugerido.feature")
                .outputCucumberJson(true)  // Asegura la generación de reportes JSON
                .parallel(2);

        generateReport(results.getReportDir());

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }*/
}
