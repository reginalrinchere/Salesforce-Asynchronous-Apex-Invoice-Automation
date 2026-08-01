@isTest
global class InvoiceCalloutMock implements HttpCalloutMock {
global HttpResponse respond(HttpRequest req) {
HttpResponse res = new HttpResponse();
res.setStatusCode(200);
res.setBody(
'{"Status":"Success"}'
);
return res;
}
}