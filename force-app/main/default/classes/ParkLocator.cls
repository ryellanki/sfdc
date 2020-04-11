public class ParkLocator {
    
    public static List<String> country (String con) {
        ParkService.ParksImplPort country = 
            new ParkService.ParksImplPort();
        return country.byCountry(con);
    }

}