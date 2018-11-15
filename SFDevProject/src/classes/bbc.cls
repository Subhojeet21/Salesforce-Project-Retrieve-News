public class bbc {
    
    public static bbc.News newsList {get;set;}
    public static HttpResponse response;
    
    public static void getMostReadNews(){
        String endpoint = Endpoints__c.getValues('bbcNews').url__c;
        if(String.isNotBlank(endpoint)){
            makeCallout(endpoint);
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No endpoint url found. Please add it to the custom settings'));
        }
    }
    
    public static HttpResponse makeCallout(String endpoint){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            system.debug(response.getBody());
            newsList = (bbc.News) JSON.deserialize(response.getBody(), bbc.News.class);
            system.debug('results--'+newsList);
        }else{
            system.debug(response.getBody());
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,String.valueOf(results.get('message')))); 
        }
        return response;
    }
    
    public class News {
        public List<Article> articles {get;set;}
    }
    
    public class Article {
        public String title {get;set;}
        public String url {get;set;}
    }
}