@isTest
public class ParkLocatorTest {

   @isTest static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        String x = 'United States';
        
        List<String> result = ParkLocator.country(x);
        // Verify that a fake result is returned
       // System.assertEquals(3.0, result); 
    }
    
}