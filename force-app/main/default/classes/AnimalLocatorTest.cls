@isTest
public class AnimalLocatorTest {
    
    @isTest static void testPostCallout() {
    // Set mock callout class 
    Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
    // This causes a fake response to be sent
    // from the class that implements HttpCalloutMock. 
   // Integer id=0;
    String response = AnimalLocator.getAnimalNameById(0);
    // Verify that the response received contains fake values
   // String contentType = response.getHeader('Content-Type');
    //System.assert(contentType == 'application/json');
    //String actualValue = response.getBody();
    //System.debug(response.getBody());
    //String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
  //  System.assertEquals(actualValue, expectedValue);
    System.assertEquals('chicken', response);
}

}