| NOTE: The ios SDK is not yet ready for use, this documentation is intended primarily for design purposes |
|:---------------------------------------------------------------------------------------------------------|



## StretchrContext ##

In order to use the features of the SDK you must first create a `StretchrContext` that will describe your Stretchr account, and authentication information.

### Creating a StretchrContext object ###

#### `initWithAccount:publicKey:privateKey` ####

To create a new StretchrContext object, you simply initialise a new object using the `initWithAccount:publicKey:privateKey` method.

```
StretchrContext *context = [[StretchrContext alloc] initWithAccount:account publicKey:pubK privateKey:privK];
// ... do work with context ...
[context release];
```

## Resources ##

### Creating new resources ###

To create a new resource, use the `StretchrContext`s `createNewResourceWithPath:` method.