Feature: Signup API Tests

  Background:
    * url 'https://api.demoblaze.com/signup'
    * def signupData = read('classpath:signupData.json')

  Scenario Outline: Crear y verificar usuarios
    Given request { username: '#(username)', password: '#(password)' }
    When method POST
    Then status 200
    And match response == <expectedResponse>

    Examples:
      | username                          | password                           | expectedResponse                                      |
      | #(signupData.newUser.username)     | #(signupData.newUser.password)      | { "success": "Sign up successful." }                  |
      | #(signupData.existingUser.username)| #(signupData.existingUser.password) | { "errorMessage": "This user already exist." }        |
