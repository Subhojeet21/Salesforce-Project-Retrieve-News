@isTest
public class bbcTest {
    
    @testSetup
    public static void setUpData(){
        Endpoints__c endpt = new Endpoints__c();
        endpt.name='bbcNews';
        endpt.url__c='https://abc.com';
        
        insert endpt;
    }
    
    public testmethod static void testCallout(){
        Test.startTest();
        	Test.setMock(HttpCalloutMock.class, new bbcCalloutMock());
        	bbc.getMostReadNews();
        Test.stopTest();
        HttpResponse response = bbc.response;
        system.debug(JSON.deserializeUntyped(response.getBody()));
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        bbc.Article art = new bbc.Article();
        List<Object> artList = (List<Object>) results.get('articles');
        system.debug('artList--'+artList[0]);
        Map<String, Object> articleMap = (Map<String, Object>) artList[0];
        art.title = String.valueOf(articleMap.get('title'));
        art.url = String.valueOf(articleMap.get('url'));
        bbc.News newsList = new bbc.News();
        newsList.articles = new List<bbc.Article>{art};
            Integer actualValue = response.getStatusCode();
        System.assertEquals(200, actualValue);
    }
    
    public testmethod static void testCalloutWithBlankEndpoint(){
        Endpoints__c endpt = Endpoints__c.getValues('bbcNews');
        endpt.url__c = '';
        update endpt;
        Test.startTest();
        	Test.setMock(HttpCalloutMock.class, new bbcCalloutMock());
        	bbc.getMostReadNews();
        Test.stopTest();
        HttpResponse response = bbc.response;
        System.assertEquals(null, response);
    }
    
    public testmethod static void testCalloutWithError(){
        Test.startTest();
        	Test.setMock(HttpCalloutMock.class, new bbcCalloutErrorMock());
        	bbc.getMostReadNews();
        Test.stopTest();
        HttpResponse response = bbc.response;
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        Integer actualValue = response.getStatusCode();
        System.assertEquals(401, actualValue);
    }
}