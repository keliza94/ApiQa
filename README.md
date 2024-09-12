
# Proyecto de Pruebas de APIs con Karate

Este proyecto está enfocado en la **automatización de pruebas de APIs** utilizando **Karate** como framework de pruebas, junto con **JUnit5** para la ejecución de pruebas. El proyecto está configurado para ser compatible con **Java 17** y utiliza **Maven** como herramienta de gestión de dependencias.

## Requisitos previos

Antes de ejecutar el proyecto, asegúrate de tener instalados los siguientes requisitos:

1. **Java Development Kit (JDK)**: versión 17  
   Descárgalo desde [aquí](https://www.oracle.com/java/technologies/javase-jdk17-downloads.html).
   
2. **Maven**: versión 3.6 o superior  
   Descárgalo desde [aquí](https://maven.apache.org/download.cgi).

## Estructura del Proyecto

El proyecto sigue la estructura estándar de un proyecto Maven, con las pruebas ubicadas en el directorio `src/test/java`.

```
.
├── src
│   ├── test
│   │   └── java
│   │       └── features
│   │           └── <archivo_de_pruebas.feature>
├── pom.xml
└── README.md
```

## Dependencias

Las dependencias principales del proyecto se gestionan a través del archivo `pom.xml`. El proyecto incluye las siguientes dependencias clave:

- **Karate**: versión 1.5.0 para la automatización de pruebas de API.
- **JUnit 5**: para la ejecución de pruebas.

El archivo `pom.xml` ya está configurado para incluir estas dependencias:

```xml
<dependency>
    <groupId>io.karatelabs</groupId>
    <artifactId>karate-junit5</artifactId>
    <version>${karate.version}</version>
    <scope>test</scope>
</dependency>
```

## Instrucciones de Instalación y Ejecución

### 1. Clonar el repositorio

Clona este repositorio en tu máquina local con el siguiente comando:

```bash
git clone <URL_del_repositorio>
cd <nombre_del_proyecto>
```

### 2. Compilar el proyecto

Compila el proyecto utilizando Maven:

```bash
mvn clean compile
```

### 3. Ejecutar las pruebas

Para ejecutar las pruebas, utiliza el siguiente comando Maven:

```bash
mvn test
```

Este comando ejecutará todos los archivos `.feature` en el directorio `src/test/java`.

### 4. Ver los reportes

Karate genera reportes automáticos de las pruebas ejecutadas. Después de la ejecución de las pruebas, los reportes se generan en la siguiente ruta:

```
APIQa/target/karate-reports/karate-summary.html
```

Puedes abrir el archivo `karate-summary.html` en cualquier navegador para visualizar los resultados de las pruebas.

## Configuración adicional

El proyecto utiliza **Maven Surefire Plugin** para la ejecución de pruebas, y está configurado para usar el encoding UTF-8:

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-surefire-plugin</artifactId>
    <version>${maven.surefire.version}</version>
    <configuration>
        <argLine>-Dfile.encoding=UTF-8</argLine>
    </configuration>
</plugin>
```

## Contacto

Si tienes preguntas o necesitas soporte con este proyecto, no dudes en contactarme.
