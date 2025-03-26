Feature: Sugerir nueva versión (trim) de vehículo

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

  Scenario: Código 200 - Sugerencia de versión enviada exitosamente
    * def uniqueName = generateName()
    * print 'Nombre generado:', uniqueName
    * def requestBody = { name: '#(uniqueName)' }
    Given path 'v2/crm/trims/suggest/9/116/21177'
    And request requestBody
    When method POST
    Then status 200
    And match response.status == 200
    And match response.data != []
    And match response.messages[0].severity == 'success'
    And match response.messages[0].text contains 'Hemos recibido tu(s) sugerencia(s)'

  Scenario: Código 400 - El nombre no cumple validaciones (tipo y longitud)
    * def requestBody = { }
    Given path 'v2/crm/trims/suggest/9/116/21177'
    And request requestBody
    When method POST
    Then status 400
    And match response.status == 400
    And match response.data == []
    And match response.messages[0].severity == 'error'
    And match response.messages[0].text contains 'El nombre debe ser menor o igual 100 caracteres'
    And match response.messages[1].severity == 'error'
    And match response.messages[1].text contains 'El nombre debe ser de tipo texto'

  Scenario: Código 401 - Token inválido
    * def requestBody = { }
    * header Authorization = 'Bearer INVALID_TOKEN'
    Given path 'v2/crm/trims/suggest/9/116/21177'
    And request requestBody
    When method POST
    Then status 401
    And match response.status == 401
    And match response.error == 'unauthorized'
    And match response.error_description == 'Access token is not valid'

