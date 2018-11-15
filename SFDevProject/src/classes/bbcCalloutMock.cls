@isTest
global class bbcCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"articles": [{"source": {"id": "bbc-news","name": "BBC News"},"author": "BBC News","title": "Test Title","description": "Test description","url": "http://www.abc.com","urlToImage": "https://abc.com/_104338517_gettyimages-1060720780.jpg", "publishedAt": "2018-11-14T15:24:18Z","content": "Test content"}]}');
        response.setStatusCode(200);
        return response; 
    }
}