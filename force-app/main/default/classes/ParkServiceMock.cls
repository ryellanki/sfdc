@isTest
global class ParkServiceMock implements WebServiceMock
{
    global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        // start - specify the response you want to send
        ParkService.byCountryResponse response_x = 
            new ParkService.byCountryResponse();
               List<String> ss=new List<String>();
               ss.add('Yellowstone');ss.add('Mackinac National Park');ss.add('Yosemite');
        response_x.return_x = ss;
        // end
        response.put('response_x', response_x); 
   }

}