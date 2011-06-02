/*
 
 Singleton macros
 Easily make any class a singleton.
 by Mat Ryer
 
 
 STEP 1
 
 #import "Singleton.h"
 
 
 STEP 2
 
 @interface YourClass : NSObject {
 
 }
 
 SingletonInterface(YourClass);
 
 @end
 
 
 STEP 3
 
 @implementation YourClass
 
 SingletonImplementation(YourClass);
 
 @end
 
 
 
 */
#define SingletonInterface(t) + (t*)sharedInstance

#define SingletonImplementation(t) static t *sharedInstance = nil; \
\
+ (t*)sharedInstance { \
@synchronized(self) { \
if (sharedInstance == nil) { \
sharedInstance = [[t alloc] init];  \
} \
return sharedInstance; \
} \
} \
\
+ (id)allocWithZone:(NSZone *)zone { \
@synchronized([t class]) { \
if (sharedInstance == nil) { \
sharedInstance = [super allocWithZone:zone]; \
return sharedInstance; \
} \
} \
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
} \
\
- (id)retain { \
return self; \
} \
\
- (NSUInteger)retainCount { \
return UINT_MAX; \
} \
\
- (void)release { \
} \
\
- (id)autorelease { \
return self; \
}
