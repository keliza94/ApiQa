Feature: Consultar todas las versiones por Marca, Modelo y Año

  Background:
    * url baseUrl
    * def carData = read('classpath:data/carData.json')
    * header Authorization = headers.Authorization
    * header Accept = headers.Accept

  Scenario: Código 200 - Respuesta exitosa
    Given path 'v2/crm/trims', carData.validData.brand, carData.validData.model, carData.validData.year
    When method GET
    Then status 200
    And print 'Response:', response

  Scenario: Código 400 - Petición incorrecta
    Given path 'v2/crm/trims', 'INVALID_BRAND', 'INVALID_MODEL', 'INVALID_YEAR'
    When method GET
    Then status 400
    And match response.status == 400
    And print 'Response:', response

  Scenario: Código 401 - Token inválido
    * configure headers = { Authorization: 'Bearer INVALID_TOKEN', Accept: 'application/json' }
    Given path 'v2/crm/trims', carData.validData.brand, carData.validData.model, carData.validData.year
    When method GET
    Then status 401
    And match response.status == 401
    And print 'Response:', response
