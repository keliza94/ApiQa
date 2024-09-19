Feature: Login API Tests

  Background:
    * url 'https://api.demoblaze.com/login'
    * def loginData = read('classpath:loginData.json')


  Scenario: Login con usuario y password correctos
    Given request { username: '#(loginData.validUser.username)', password: '#(loginData.validUser.password)' }
    When method POST
    Then status 200
    And print 'Auth_token:', response.Auth_token

  Scenario: Login con usuario y password incorrectos
    Given request { username: '#(loginData.invalidUser.username)', password: '#(loginData.invalidUser.password)' }
    When method POST
    Then status 200
    And match response == { "errorMessage": "User does not exist." }
