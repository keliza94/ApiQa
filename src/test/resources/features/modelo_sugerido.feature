Feature: Sugerir un nuevo modelo de vehículo

  Background:
    * url baseUrl
    * header Authorization = headers.Authorization
    * header Accept = headers.Accept
    * def generateName =
"""
function() {
  var UUID = Java.type('java.util.UUID');
  var Date = Java.type('java.util.Date');
  var uuid = UUID.randomUUID().toString();
  var timestamp = new Date().getTime();
  return 'model_' + timestamp + '_' + uuid;
}
"""

  Scenario: Código 200 - Sugerencia enviada exitosamente
    * def uniqueName = generateName()
    * print 'Nombre generado:', uniqueName
    * def requestBody = { name: '#(uniqueName)' }
    Given path 'v2/crm/models/suggest/1485'
    And request requestBody
    When method POST
    Then status 200
    And match response.status == 200
    And match response.data != []
    And match response.messages[0].severity == 'success'


  Scenario: Código 400 - Validación por nombre inválido
    * def requestBody = { "name": 1234567890 }  # No es string y puede exceder longitud como string
    Given path 'v2/crm/models/suggest/1485'
    And request requestBody
    When method POST
    Then status 400
    And match response.status == 400
    And match response.data == []
    And match response.messages[0].severity == 'error'
    And match response.messages[0].text contains 'El nombre debe ser menor o igual 100 caracteres'
    And match response.messages[1].severity == 'error'
    And match response.messages[1].text contains 'El nombre debe ser de tipo texto'

  Scenario: Código 401 - Token de acceso ausente
    * def requestBody = { }
    * header Authorization = 'Bearer INVALID_TOKEN'
    Given path 'v2/crm/models/suggest/1485'
    And header Accept = 'application/json'
    And request requestBody
    When method POST
    Then status 401
    And match response.status == 401
    And match response.error == 'unauthorized'
    And match response.error_description == 'Access token is not valid'

