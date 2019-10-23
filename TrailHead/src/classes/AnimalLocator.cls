/**
 * Created by IlarionTokarskyi on 10/18/2019.
 */

public with sharing class AnimalLocator {
    public static String getAnimalNameById(Integer id) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        String result = '';
        if (response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<string,object> animals = (map<string,object>) results.get('animal');
            result = (String) animals.get('name');
        }
        return result;
    }
}