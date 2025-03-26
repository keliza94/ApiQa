Feature: Sugerir un nuevo año para modelo de vehículo

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Authorization = headers.Authorization
    * def generarAnioAleatorio =
  """
  function() {
    var now = new Date();
    var max = now.getFullYear() + 1000;
    var min = 2000;
    var randomYear = Math.floor(Math.random() * (max - min + 1)) + min;
    return '' + randomYear;
  }
  """

  Scenario: Código 200 - Sugerencia de año enviada exitosamente
    * header Authorization = headers.Authorization
    * def year = generarAnioAleatorio()
    * def requestBody = { year: #(year) }
    Given path 'v2/crm/years/suggest/9/116'
    And request requestBody
    When method POST
    Then status 200
    And match response.status == 200
    And match response.data != null
    And match response.messages[0].severity == 'success'
    And match response.messages[0].text contains 'Hemos recibido tu(s) sugerencia(s)'

  Scenario: Código 400 - Año inválido
    * header Authorization = headers.Authorization
    * def requestBody = { year: "año_invalido" }
    Given path 'v2/crm/years/suggest/9/116'
    And request requestBody
    When method POST
    Then status 400
    And match response.status == 400
    And match response.data == []
    And match response.messages[0].severity == 'error'
    And match response.messages[0].text contains 'El año ingresado no es válido'

  Scenario: Código 401 - Token inválido
    * header Authorization = 'Bearer token_invalido'
    * def requestBody = { year: "2025" }
    Given path 'v2/crm/years/suggest/9/116'
    And request requestBody
    When method POST
    Then status 401
    And match response.status == 401
    And match response.error == 'unauthorized'
    And match response.error_description == 'Access token is not valid'
