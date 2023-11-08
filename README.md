# DynamicMapper

[![CI Status](https://img.shields.io/travis/Abdulrahman Qasem/DynamicMapper.svg?style=flat)](https://travis-ci.org/Abdulrahman Qasem/DynamicMapper)
[![Version](https://img.shields.io/cocoapods/v/DynamicMapper.svg?style=flat)](https://cocoapods.org/pods/DynamicMapper)
[![License](https://img.shields.io/cocoapods/l/DynamicMapper.svg?style=flat)](https://cocoapods.org/pods/DynamicMapper)
[![Platform](https://img.shields.io/cocoapods/p/DynamicMapper.svg?style=flat)](https://cocoapods.org/pods/DynamicMapper)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DynamicMapper is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DynamicMapper'
```

## Author

Abdulrahman Qasem, Abdulrahmanq1995@gmail.com

## License

DynamicMapper is available under the MIT license. See the LICENSE file for more info.



DynamicMapper
============
[![Version](https://img.shields.io/cocoapods/v/DynamicMapper.svg?style=flat)](https://cocoapods.org/pods/DynamicMapper)
[![License](https://img.shields.io/cocoapods/l/DynamicMapper.svg?style=flat)](https://cocoapods.org/pods/DynamicMapper)
[![Platform](https://img.shields.io/cocoapods/p/DynamicMapper.svg?style=flat)](https://cocoapods.org/pods/DynamicMapper)

DynamicMapper is a framework written in Swift for dynamically decoding and encoding models (reference and value types) using Apple native `Decodable` and `Encodable` protocols. 

- [Features](#features)
- [The Basics](#the-basics)
- [Mapping Nested Objects](#easy-mapping-of-nested-objects)
- [Custom Transformations](#custom-transforms)
- [Subclassing](#subclasses)
- [Generic Objects](#generic-objects)
- [Mapping Context](#mapping-context)
- [ObjectMapper + Alamofire](#objectmapper--alamofire) 
- [ObjectMapper + Realm](#objectmapper--realm)
- [Projects using ObjectMapper](#projects-using-objectmapper)
- [To Do](#to-do)
- [Contributing](#contributing)
- [Installation](#installation)

# Features:
- Decoding and encoding using native `JSONDecoder` and `JSONEncoder`
- Has the full functionality of `Codable = Decodable & Encodable` protocols
- Nested Objects encoding and decoding (Dynamic Mapping)
- Rreference & Value Types support
- Dynamic Object Insertion and Creation
- Safely nested item fetching
- smooth transformation since it works directly with your `Codable`  models without any changes
- Native replacment of [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)

# The Basics
Like native `JSONDecoder` and `JSONEncoder` To support dynamic mapping, a class or struct just needs to implement the `DynamicDecodable` protocol for decoding, `DynamicEncodable` protocol for encoding or `DynamicCodable` protocol for both decoding and encoding togoether
```swift
 protocol DynamicDecodable:Decodable
 protocol DynamicEncodable:Encodable
 protocol DynamicCodable:DynamicDecodable,DynamicEncodable
```

```swift
 var dynamicSelf: DynamicClass?
 func dynamicMapping(mappingType: DynamicMappingType) {}
```
DynamicMapper uses the ```<--``` operator to set nested member variable.

```swift
class User: DynamicDecodable {
    var dynamicSelf: DynamicClass?
    
    var username: String?
    var lastname: String?
    var age: Int?
    var weight: Double!
    var birthday: Date?
    var bestFamilyPhoto:URL?                    // Nested URL 
    var numberOfChildren:Int?                   // Nested Int 
    var bestFriend: User?                       // Nested User object
    var friends: [User]?                        // Array of Users
    
    func dynamicMapping(mappingType: DynamicMappingType) {
        bestFamilyPhoto   <--  ds.alboms.familyAlbom.bestPhoto
        numberOfChildren  <--  ds.familyInfo.childrenCount
        bestFriend?.dynamicMapping(mappingType: mappingType)
        friends?.dynamicMapping(mappingType: mappingType)
    }
}


struct Temperature: DynamicDecodable {
    var dynamicSelf: DynamicClass?
    
    var celsius: Double?
    var fahrenheit: Double?
    
    mutating func dynamicMapping(mappingType: DynamicMapper.DynamicMappingType) {
        // nothing to do with model's level parameters, Codable will take care of them
        // unless you want to use custom name
    }
}

// Custom names
struct Temperature: DynamicDecodable {
    var dynamicSelf: DynamicClass?
    
    var celsiusTemperature: Double?
    var fahrenheitTemperature: Double?
    
    mutating func dynamicMapping(mappingType: DynamicMappingType) {
        celsiusTemperature     <--  ds.celsius
        fahrenheitTemperature  <--  ds.fahrenheit
    }
}

```

Once your class implements `DynamicDecodable` it can be easily decoded using `DynamicJSONDecoder` class. 

Decoding:
```swift
 do {
     let userModel = try DynamicJSONDecoder().decode(User.self, from: userDataFromServer)
 } catch  {
     print(error.localizedDescription)
 }
```

Encoding:
```swift
  do {
      let userData = try DynamicJSONEncoder().encode(userModel)
  } catch  {
      print(error.localizedDescription)
  }
```


DynamicMapper can decode and encode all types supported by `JSONDecoder` and `JSONEncoder`:
- `String`
- `Int`
- `Float`
- `Double`
- `Bool`
- `Array` (as long as the elements are also `Codable`)
- `Dictionary` (as long as the keys and values are `Codable`)
- Custom structs and classes that conform to `Codable`
- Optional types that conform to `Codable`
- Enumerations with associated values (as long as the associated values are `Codable`)
- `Date`
- `URL`
- `Data`

## `DynamicCodable` Protocol

#### `mutating func dynamicMapping(mappingType:DynamicMappingType)` 
This function is where all nested items and models definitions should go. this function is executed after successful  encoding and decoding proccess. It is the only function that is called on the object.

#### `var dynamicSelf:DynamicClass?` 
Dynamic copy of the object that we will use to dynamically access the nested property or model, we can use either `dynamicSelf` or its alias `ds` to access the dynamic model when `dynamicMapping(mappingType:DynamicMappingType)` function get called



<table>
  <tr>
    <th>DynamicCodable</th>
  </tr>
  <tr>
    <th colspan="2">Properties</th>
  </tr>
  <tr>
    <td>
<pre>
<strong>var</strong> bestFamilyPhoto: URL?
<strong>var</strong> numberOfChildren: Int?
</pre>
  </td>
  </tr>
  <tr>
    <th colspan="2">Data -> Model (Decoding)</th>
  </tr>
  <tr>
    <td>
<th>
func dynamicMapping(mappingType: DynamicMappingType) {
    bestFamilyPhoto   <--  ds.alboms.familyAlbom.bestPhoto
    numberOfChildren  <--  ds.familyInfo.childrenCount
}
</th>
  </td>
  </tr>
  <tr>
    <th colspan="2">Model -> Data (Encoding)</th>
  </tr>
  <tr>
    <td>
<pre>
func dynamicMapping(mappingType: DynamicMappingType) {
    bestFamilyPhoto   -->  {ds.alboms.familyAlbom.bestPhoto.set($0)}
    numberOfChildren  -->  {ds.familyInfo.childrenCount.set($0)}
}
</pre>
    </td>
    </pre>
  </td>
  </tr>
  <tr>
    <th colspan="2">Decoding & Encoding</th>
  </tr>
  <tr>
    <td>
<pre>
func dynamicMapping(mappingType: DynamicMappingType) {
    switch mappingType {
        case .decoding:
            bestFamilyPhoto   <--  ds.alboms.familyAlbom.bestPhoto
            numberOfChildren  <--  ds.familyInfo.childrenCount
        case .encoding:
            bestFamilyPhoto   -->  {ds.alboms.familyAlbom.bestPhoto.set($0)}
            numberOfChildren  -->  {ds.familyInfo.childrenCount.set($0)}        
        }
}
</pre>
    </td>
</table>

#### `init(map: Map) throws`

This throwable initializer is used to map immutable properties from the given `Map`. Every immutable property should be initialized in this initializer.

This initializer throws an error when:
- `Map` fails to get a value for the given key
- `Map` fails to transform a value using `Transform`

`ImmutableMappable` uses `Map.value(_:using:)` method to get values from the `Map`. This method should be used with the `try` keyword as it is throwable. `Optional` properties can easily be handled using `try?`.

```swift
init(map: Map) throws {
    name      = try map.value("name") // throws an error when it fails
    createdAt = try map.value("createdAt", using: DateTransform()) // throws an error when it fails
    updatedAt = try? map.value("updatedAt", using: DateTransform()) // optional
    posts     = (try? map.value("posts")) ?? [] // optional + default value
    surname    = try? map.value("surname", default: "DefaultSurname") // optional + default value as an argument
}
```

#### `mutating func mapping(map: Map)`

This method is where the reverse transform is performed (model to JSON). Since immutable properties cannot be mapped with the `<-` operator, developers have to define the reverse transform using the `>>>` operator.

```swift
mutating func mapping(map: Map) {
    name      >>> map["name"]
    createdAt >>> (map["createdAt"], DateTransform())
    updatedAt >>> (map["updatedAt"], DateTransform())
    posts     >>> map["posts"]
}
```

# Easy Mapping of Nested Objects
ObjectMapper supports dot notation within keys for easy mapping of nested objects. Given the following JSON String:
```json
"distance" : {
     "text" : "102 ft",
     "value" : 31
}
```
You can access the nested objects as follows:
```swift
func mapping(map: Map) {
    distance <- map["distance.value"]
}
```
Nested keys also support accessing values from an array. Given a JSON response with an array of distances, the value could be accessed as follows:
```swift
distance <- map["distances.0.value"]
```
If you have a key that contains `.`, you can individually disable the above feature as follows:
```swift
func mapping(map: Map) {
    identifier <- map["app.identifier", nested: false]
}
```
When you have nested keys which contain `.`, you can pass the custom nested key delimiter as follows ([#629](https://github.com/tristanhimmelman/ObjectMapper/pull/629)):
```swift
func mapping(map: Map) {
    appName <- map["com.myapp.info->com.myapp.name", delimiter: "->"]
}
```

# Custom Transforms
ObjectMapper also supports custom transforms that convert values during the mapping process. To use a transform, simply create a tuple with `map["field_name"]` and the transform of your choice on the right side of the `<-` operator:
```swift
birthday <- (map["birthday"], DateTransform())
```
The above transform will convert the JSON Int value to an Date when reading JSON and will convert the Date to an Int when converting objects to JSON.

You can easily create your own custom transforms by adopting and implementing the methods in the `TransformType` protocol:
```swift
public protocol TransformType {
    associatedtype Object
    associatedtype JSON

    func transformFromJSON(_ value: Any?) -> Object?
    func transformToJSON(_ value: Object?) -> JSON?
}
```

### TransformOf
In a lot of situations you can use the built-in transform class `TransformOf` to quickly perform a desired transformation. `TransformOf` is initialized with two types and two closures. The types define what the transform is converting to and from and the closures perform the actual transformation. 

For example, if you want to transform a JSON `String` value to an `Int` you could use `TransformOf` as follows:
```swift
let transform = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in 
    // transform value from String? to Int?
    return Int(value!)
}, toJSON: { (value: Int?) -> String? in
    // transform value from Int? to String?
    if let value = value {
        return String(value)
    }
    return nil
})

id <- (map["id"], transform)
```
Here is a more condensed version of the above:
```swift
id <- (map["id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
```

# Subclasses

Classes that implement the `Mappable` protocol can easily be subclassed. When subclassing mappable classes, follow the structure below:

```swift
class Base: Mappable {
    var base: String?
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        base <- map["base"]
    }
}

class Subclass: Base {
    var sub: String?

    required init?(map: Map) {
        super.init(map)
    }

    override func mapping(map: Map) {
        super.mapping(map)
        
        sub <- map["sub"]
    }
}
```

Make sure your subclass implementation calls the right initializers and mapping functions to also apply the mappings from your superclass.

# Generic Objects

ObjectMapper can handle classes with generic types as long as the generic type also conforms to `Mappable`. See the following example:
```swift
class Result<T: Mappable>: Mappable {
    var result: T?

    required init?(map: Map){

    }

    func mapping(map: Map) {
        result <- map["result"]
    }
}

let result = Mapper<Result<User>>().map(JSON)
```

# Mapping Context

The `Map` object which is passed around during mapping, has an optional `MapContext` object that is available for developers to use if they need to pass information around during mapping. 

To take advantage of this feature, simply create an object that implements `MapContext` (which is an empty protocol) and pass it into `Mapper` during initialization. 
```swift
struct Context: MapContext {
    var importantMappingInfo = "Info that I need during mapping"
}

class User: Mappable {
    var name: String?
    
    required init?(map: Map){
    
    }
    
    func mapping(map: Map){
        if let context = map.context as? Context {
            // use context to make decisions about mapping
        }
    }
}

let context = Context()
let user = Mapper<User>(context: context).map(JSONString)
```

# ObjectMapper + Alamofire

If you are using [Alamofire](https://github.com/Alamofire/Alamofire) for networking and you want to convert your responses to Swift objects, you can use [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper). It is a simple Alamofire extension that uses ObjectMapper to automatically map JSON response data to Swift objects.


# ObjectMapper + Realm

ObjectMapper and Realm can be used together. Simply follow the class structure below and you will be able to use ObjectMapper to generate your Realm models:

```swift
class Model: Object, Mappable {
    dynamic var name = ""

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        name <- map["name"]
    }
}
```

If you want to serialize associated RealmObjects, you can use [ObjectMapper+Realm](https://github.com/jakenberg/ObjectMapper-Realm). It is a simple Realm extension that serializes arbitrary JSON into Realm's `List` class.

To serialize Swift `String`, `Int`, `Double` and `Bool` arrays you can use [ObjectMapperAdditions/Realm](https://github.com/APUtils/ObjectMapperAdditions#realm-features). It'll wrap Swift types into RealmValues that can be stored in Realm's `List` class.

Note: Generating a JSON string of a Realm Object using ObjectMappers' `toJSON` function only works within a Realm write transaction. This is because ObjectMapper uses the `inout` flag in its mapping functions (`<-`) which are used both for serializing and deserializing. Realm detects the flag and forces the `toJSON` function to be called within a write block even though the objects are not being modified.

# Projects Using ObjectMapper
- [Xcode Plugin for generating `Mappable` and `ImmutableMappable` code](https://github.com/liyanhuadev/ObjectMapper-Plugin)

- [Json4Swift - Supports generating `ImmutableMappable` structs online (no plugins needed)](http://www.json4swift.com)

- [JSON to Model - Template based MacOS app which generates structs with customisation.](https://github.com/chanonly123/Json-Model-Generator)  [⬇️Download App](https://github.com/chanonly123/Json-Model-Generator/raw/master/JsonToModel.zip)

If you have a project that utilizes, extends or provides tooling for ObjectMapper, please submit a PR with a link to your project in this section of the README.

# To Do
- Improve error handling. Perhaps using `throws`
- Class cluster documentation

# Contributing

Contributions are very welcome 👍😃. 

Before submitting any pull request, please ensure you have run the included tests and they have passed. If you are including new functionality, please write test cases for it as well.

# Installation
### Cocoapods
ObjectMapper can be added to your project using [CocoaPods 0.36 or later](http://blog.cocoapods.org/Pod-Authors-Guide-to-CocoaPods-Frameworks/) by adding the following line to your `Podfile`:

```ruby
pod 'ObjectMapper', '~> 3.5' (check releases to make sure this is the latest version)
```

### Carthage
If you're using [Carthage](https://github.com/Carthage/Carthage) you can add a dependency on ObjectMapper by adding it to your `Cartfile`:

```
github "tristanhimmelman/ObjectMapper" ~> 3.5 (check releases to make sure this is the latest version)
```

### Swift Package Manager
To add ObjectMapper to a [Swift Package Manager](https://swift.org/package-manager/) based project, add:

```swift
.package(url: "https://github.com/tristanhimmelman/ObjectMapper.git", .upToNextMajor(from: "4.1.0")),
```
to your `Package.swift` files `dependencies` array.

### Submodule
Otherwise, ObjectMapper can be added as a submodule:

1. Add ObjectMapper as a [submodule](http://git-scm.com/docs/git-submodule) by opening the terminal, `cd`-ing into your top-level project directory, and entering the command `git submodule add https://github.com/tristanhimmelman/ObjectMapper.git`
2. Open the `ObjectMapper` folder, and drag `ObjectMapper.xcodeproj` into the file navigator of your app project.
3. In Xcode, navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
4. Ensure that the deployment target of `ObjectMapper.framework` matches that of the application target.
5. In the tab bar at the top of that window, open the "Build Phases" panel.
6. Expand the "Target Dependencies" group, and add `ObjectMapper.framework`.
7. Click on the `+` button at the top left of the panel and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add `ObjectMapper.framework`.
