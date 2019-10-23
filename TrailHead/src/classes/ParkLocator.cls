/**
 * Created by IlarionTokarskyi on 10/18/2019.
 */

public with sharing class ParkLocator {
    public static String[] country(String country){
        ParkService.ParksImplPort parks = new ParkService.ParksImplPort();
        String[] parksname = parks.byCountry(country);
        return parksname;
    }
}