Feature: Login API Tests

  Background:
    * url 'https://api.demoblaze.com/login'

  Scenario: Login con usuario y password correctos
    Given request { username: 'keliza.vargas@gmail.com', password: 'Hello123' }
    When method POST
    Then status 200
    And print 'Auth_token:', response.Auth_token


  Scenario: Login con usuario y password incorrectos
    Given request { username: 'usuario_incorrecto', password: 'contrasena_erronea' }
    When method POST
    Then status 200
    And match response == { "errorMessage": "User does not exist." }