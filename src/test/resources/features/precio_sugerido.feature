Feature: Obtener precio sugerido de vehículo

  Background:
    * url baseUrl
    * header Authorization = headers.Authorization
    * header Accept = headers.Accept

  Scenario: Código 200 - Obtener precio sugerido por marca, modelo, año y versión
    Given path 'v2/crm/vehicles/suggest-price'
    And param brandId = 9
    And param modelId = 116
    And param yearId = 21177
    And param versionId = 5575
    When method GET
    Then status 200
    And match response.status == 200
    And assert response.data.minValue >= 0
    And assert response.data.avgMarketValue >= response.data.minValue
    And assert response.data.maxValue >= response.data.avgMarketValue
    And match response.messages == []

  Scenario: Código 400 - Provider no concuerda
    Given path 'v2/crm/vehicles/suggest-price'
    And param brandId = 99999
    And param modelId = 116
    And param yearId = 21177
    And param versionId = 5575
    When method GET
    Then status 400
    And match response.status == 400
    And match response.data == []
    And match response.messages[0].severity == 'error'
    And match response.messages[0].text contains 'Invalid brand, model, year or trim'

  Scenario: Código 401 - Token inválido (Access token is not valid)
    * header Authorization = 'Bearer INVALID_TOKEN'
    * header Accept = 'application/json'
    Given path 'v2/crm/vehicles/suggest-price'
    And param brandId = 2315315231
    And param modelId = 116
    And param yearId = 21177
    And param versionId = 5575
    When method GET
    Then status 401
    And match response.status == 401
    And match response.error == 'unauthorized'
    And match response.error_description == 'Access token is not valid'


