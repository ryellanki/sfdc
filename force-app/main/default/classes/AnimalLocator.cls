public class AnimalLocator {
  
    public static String getAnimalNameById(Integer id) {
          Map<Integer,String> animalIdnName= new Map<Integer, String>();
         String animalName='';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
    
           Map<String, object> animals = (Map<String, Object>) results.get('animal');
            
           animalName=(String)animals.get('name');
        }
           
        return animalName;
        
    }
}