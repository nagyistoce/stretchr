

## Tutorial: Using the Stretchr iOS SDK ##

### Get started ###

  * see [Installing Stretchr iOS SDK](iossdk_installing.md)

### Setting your `key` and `secret` ###

In order to authenticate with Stretchr, you must set your account name, key and secret.  This can be done once, usually in your AppDelegate.

```
[[SRContext currentContext] setAccountName:@"your-account-name" key:@"your-key" secret:@"your-secret"];
```

`your-account-name` - The name of your account (the subdomain part in `x.xapi.co`)

`your-key` - Your unique key provided by Stretchr

`your-secret` - Your secret string provided by Stretchr

### Creating a new resource ###

We are going to create a new resource to hold users feedback.  We do not need to define anything, instead we can just save our first resource when we need to:

```
SRResource *resource = [[SRResource alloc] initWithPath:@"/feedback"];
[resource setParameterValue:@"John" forKey:@"name"];
[resource setParameterValue:@"I love this service" forKey:@"comment"];
[resource createThenCallTarget:self selector:@selector(methodToSendResponseTo:)];
```

`methodToSendResponseTo` - The method to call (on the target) when the Stretchr service has responded, with either a success or an error.  The one and only argument passed to the method is an `SRResponse` object.