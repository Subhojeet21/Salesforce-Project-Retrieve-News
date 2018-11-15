@isTest
global class bbcCalloutErrorMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"status": "error","code": "apiKeyMissing","message": "Your API key is missing. Append this to the URL with the apiKey param, or use the x-api-key HTTP header."}');
        response.setStatusCode(401);
        return response; 
    }
}