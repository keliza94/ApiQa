Feature: Obtener descripción de un vehículo con AI

  Background:
    * url baseUrl
    * header Authorization = headers.Authorization
    * header Accept = headers.Accept
    * def requestBody = read('classpath:data/descriptionRequestBody.json')
    * def carData = read('classpath:data/carData.json')

  Scenario: Código 200 - Descripción generada exitosamente
    Given path 'v2/crm/vehicles/description-ai', carData.validData.vehicleId
    And request requestBody
    When method PUT
    Then status 200
    And print 'Response:', response
    And match response.data == 'OK'
    And match response.status == 200
    And match response.messages == []

  Scenario: Código 400 - Petición incorrecta
    Given path 'v2/crm/vehicles/description-ai', carData.invalidData.vehicleId
    And request requestBody
    When method PUT
    Then status 400
    And print 'Response:', response
    And match response.description == 'Provider no concuerda, por favor comuníquese con operaciones.'

  Scenario: Código 401 - Token inválido
    * header Authorization = 'Bearer INVALID_TOKEN'
    Given path 'v2/crm/vehicles/description-ai', carData.validData.vehicleId
    And request requestBody
    When method PUT
    Then status 401
    And print 'Response:', response
    And match response.status == 401
    And match response.error == 'unauthorized'
    And match response.error_description == 'Access token is not valid'