Feature: challenge api pet store karate test script

  Background:
    * url baseUrl

  Scenario Outline: create a pet and then get it by id and update a pet
    * def payload = read('classpath:some-payload-json/pet.json')

    * def responseSchema =
    """
    {
        "id": #number,
        "category": {
          "id": #number,
          "name": #string
        },
        "name": #string,
        "photoUrls": #array,
        "tags": #array,
        "status": #string
      }
    """

    * payload.name = <name>

    Given path 'pet'
    And request payload
    When method post
    Then status 200
    And match response == responseSchema

    * def id = response.id
    * print 'created id is: ', id

    Given path 'pet',id
    When method get
    Then status 200
    And match response == responseSchema

    * payload.id = id
    * payload.name = <updatedName>
    * print 'the new payload is: ', payload

    Given path 'pet'
    And request payload
    When method put
    Then status 200
    And match response == responseSchema

    Given path 'pet',id
    When method get
    Then status 200
    And match response == responseSchema

    Examples:
    |name|updatedName|
    |'Ghia'|'Miel'|
    |'Negro'|'Goofy'|
    |'Ghia'|'Miel'|
    |'Negro'|'Goofy'|
    |'Ghia'|'Miel'|