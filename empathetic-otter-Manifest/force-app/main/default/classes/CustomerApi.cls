@RestResource(urlMapping='/customers/*') global with sharing class CustomerApi {
@HttpPost
global static void createCustomer() {
RestRequest req = RestContext.request;
String body = req.requestBody.toString();
CustomerWrapper wrapper = (CustomerWrapper)JSON.deserialize(body, CustomerWrapper.class);
Account acc = new Account(Name = wrapper.name);
insert acc;
}
global class CustomerWrapper {
                     public String name;
}
}