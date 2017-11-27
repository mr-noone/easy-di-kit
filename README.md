# EasyDIKit

EasyDIKit is an Objective-C dependency injection framework for iOS.

## Installation

Installation through CocoaPods.

```ruby
platform :ios, '8.0'

target 'YourTarget' do
    pod 'EasyDIKit', '~> 1.0.0'
end
```

## Usage

First, create a sub-class of DIAssembly.

```objective-c
@interface SomeAssembly : DIAssembly

- (Person *)commonPerson;
- (Person *)commonSingletonPerson;

@end
```

By default object is instantiated by calling `new`.

```objective-c
@implementation SomeAssembly

- (Person *)commonPerson {
    return [DIFactory instanceOfClass:Person.class];
}

- (Person *)commonSingletonPerson {
    // This method return a singleton of class
    return [DIFactory singletonOfClass:Person.class];
}

@end
```

Create objects using your own initializers with `DIFactoryInitializer` block.

```objective-c
@implementation SomeAssembly

- (Person *)commonPerson {
    DIFactoryInitializer initializer = ^(DIInitializer *initializer) {
        [initializer setSelector:@selector(initWithFirstName:lastName)];
        [initializer injectParameter:@"John"];
        [initializer injectParameter:@"Smith"];
    };
    
    return [DIFactory instanceOfClass:Person.class
                          initializer:initializer
                           injections:nil];
}

@end
```

Inject properties using `DIFactoryInjections` block.

```objective-c
@implementation SomeAssembly

- (Person *)commonPerson {
    DIFactoryInjections injections = ^(DIInjection *injections) {
        [injections injectProperty:@selector(firstName) with:@"John"];
        [injections injectProperty:@selector(lastName) with:@"Smith"];
    };
    
    return [DIFactory instanceOfClass:Person.class
                          initializer:nil
                           injections:injections];
}

@end
```

Inject method using `DIFactoryInjections` block.

```objective-c
@implementation SomeAssembly

- (Person *)commonPerson {
    DIInjectionParameters parameters = ^(DIMethod *method) {
        [method injectParameter:@"John"];
    };
    
    DIFactoryInjections injections = ^(DIInjection *injections) {
        [injections injectMethod:@selector(setFirstName:)
                      parameters:parameters];
    };
    
    return [DIFactory instanceOfClass:Person.class
                          initializer:nil
                           injections:injections];
}

@end
```

Obtain objects as follows:

```objective-c
SomeAssembly *commonAssembly = [SomeAssembly assembly];
Person *person = [commonAssembly commonPerson];
```

Property injects automatically if it is subclassed form `DIAssembly`.

```objective-c
@interface SomeAssembly : DIAssembly
@end

@interface AppAssembly : DIAssembly

// This property inject automatically
@property (strong, nonatomic) SomeAssembly *someAssembly;

@end
```

## License

MIT license. See the [LICENSE file](https://github.com/mr-noone/easy-di-kit/blob/master/LICENSE) for details.
