Feature: Signup API Tests

  Background:
    * url 'https://api.demoblaze.com/signup'

  Scenario: Crear un nuevo usuario en signup
    Given request { username: 'kelizvargas@gmail.com', password: 'Hello123' }
    When method POST
    Then status 200

  Scenario: Intentar crear un usuario ya existente
    Given request { username: 'existente_usuario', password: 'contrasena123' }
    When method POST
    Then status 200
    And match response == { "errorMessage": "This user already exist." }
