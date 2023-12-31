DynamicMapper
============
[![Version](https://img.shields.io/cocoapods/v/DynamicMapper.svg?style=flat)](https://cocoapods.org/pods/DynamicMapper)
[![License](https://img.shields.io/cocoapods/l/DynamicMapper.svg?style=flat)](https://cocoapods.org/pods/DynamicMapper)
[![Platform](https://img.shields.io/badge/Platforms-macOS_iOS_tvOS_watchOS_vision_OS-Green?style=flat-square)](https://cocoapods.org/pods/DynamicMapper)

DynamicMapper is a framework written in Swift for dynamically decoding and encoding models (reference and value types) using Swift native `Decodable` and `Encodable` protocols. 

- [Installation](#installation)
- [Features](#features)
- [The Basics](#the-basics)
- [Easy Transformation from `Codable`](#easy-transformation-from-codable)
- [Mapping Nested Objects](#easy-mapping-of-nested-objects)
- [Easy Json Insersion](#easy-json-insersion)
- [DynamicMapper + Realm](#dynamicmapper--realm)
- [Contributing](#contributing)
- [Author](#author)
- [License](#license)

# Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

# Installation
### Cocoapods
DynamicMapper is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DynamicMapper', '~> 2.0.1' (check releases to make sure this is the latest version)
```

### Swift Package Manager
To add DynamicMapper to a [Swift Package Manager](https://swift.org/package-manager/) based project, add:

```swift
.package(url: "https://github.com/AbdulrahmanQasem95/DynamicMapper.git", .upToNextMajor(from: "2.0.1")),
```
to your `Package.swift` files `dependencies` array.

# Features:
- Decoding and encoding using native `JSONDecoder` and `JSONEncoder`
- Has the full functionality of `Codable = Decodable & Encodable` protocols
- Nested Objects encoding and decoding (Dynamic Mapping)
- Rreference & Value types support
- Dynamic object insertion and creation
- Safely nested object fetching
- Support subclassing
- Smooth transformation since it works directly with your `Codable` models without any changes
- Compatible with [Realm](https://github.com/realm/realm-swift)
- Native replacment of [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)
- Support Back to iOS 11, macOS 10.13, tvOS 11, and watchOS 4.

# The Basics
Like native `JSONDecoder` and `JSONEncoder` To support dynamic mapping, a class or struct just needs to implement the `DynamicDecodable` protocol for decoding, `DynamicEncodable` protocol for encoding or `DynamicCodable` protocol for both decoding and encoding togoether
```swift
 protocol DynamicCodable:DynamicDecodable,DynamicEncodable
```

```swift
 var dynamicSelf: DynamicClass?
 func dynamicMapping(mappingType: DynamicMappingType) {}
```
DynamicMapper uses the ```<--``` operator and `ds` to set nested member variable.
`ds` is a safe non optional alias of `dynamicSelf`

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


# Easy Transformation from `Codable`
Since `DynamicJSONDecoder` inherit `JSONDecoder` and `DynamicJSONEncoder` inherit `JSONEncoder`, all your `Codable` classes will work same like before with the new dynamic decoder and encoder without any changes.

This will allow you to move smoothly and easily from ordinary `Codable` to `DynamicCodable` and you can even mix them togethor.
 
You can keep the ordinary `Codable` and use `DynamicCodable` only for models where you need to access nested object without defining the implecit objects or where you need to use custom names ...
```json
{
  "title": "Swift",
  "category": "Programming Languages",
  "teacher": {
    "firstName": "Abdulrahman",
    "lastName": "Qasem"
  }
}
```
```swift
class Subject:Codable {
    var title:String
    var category:String
    var teacher:User?
}

class User:Codable {
    var firstName:String
    var lastName:String
}

 do {
     let subjectModel = try DynamicJSONDecoder().decode(Subject.self, from: subjectData)
     print(subjectModel.teacher.firstName) //Abdulrahman
 } catch  {
     print(error.localizedDescription)
 }
```
or using DynamicMapper
```swift
class Subject:DynamicCodable {
    var dynamicSelf: DynamicClass?
    
    var title:String
    var category:String
    var teacherName:String?  //Abdulrahman
    
    func dynamicMapping(mappingType: DynamicMappingType) {
        teacherName   <--   ds.teacher.firstName
    }
}

 do {
     let subjectModel = try DynamicJSONDecoder().decode(Subject.self, from: subjectData)
     print(teacherName)
 } catch  {
     print(error.localizedDescription)
 }
```

## `DynamicCodable` Protocol

#### `mutating func dynamicMapping(mappingType:DynamicMappingType)` 
This function is where all nested items and models definitions should go. this function is executed during encoding and decoding proccess. It is the only function that is called on the object.

#### `var dynamicSelf:DynamicClass?` 
Dynamic copy of the object that we will use to dynamically access the nested properties or models, we can use either `dynamicSelf` or its safe non optional alias `ds` to access the dynamic model when `dynamicMapping(mappingType:DynamicMappingType)` function get called



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
<pre>
func dynamicMapping(mappingType: DynamicMappingType) {
    bestFamilyPhoto   <--  ds.alboms.familyAlbom.bestPhoto
    numberOfChildren  <--  ds.familyInfo.childrenCount
}
</pre>
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



# Easy Mapping of Nested Objects
DynamicMapper supports dot notation within keys for easy mapping of nested objects. Given the following JSON String:
```json
{
    "property0": "Value 0",
    "level1": {
        "property1": "Value 1",
        "level2": {
            "property2": 10,
            "level3": {
                "property3": "Value 3",
                "level4": {
                    "property4": "Value 4",
                    "level5": {
                        "property5": "Value 5",
                        "level6Array": [
                            {
                                "item1": "Item A",
                                "item2": 100
                            },
                            {
                                "item1": "Item C",
                                "item2": 200
                            },
                            {
                                "item1": "Item E",
                                "item2": 300
                            }
                        ]
                    }
                }
            }
        }
    }
}
```
You can access the nested objects as follows:
```swift
 var property2:Int?
 func dynamicMapping(mappingType: DynamicMappingType) {
     property2   <--   ds.level1.level2.property2
 }
```
Nested keys also support accessing values from an array
```swift
 var secondArrayItem_1_OfLevel_6:String?
 func dynamicMapping(mappingType: DynamicMappingType) {
    secondArrayItem_1_OfLevel_6 <--  ds.level1.level2.level3.level4.level5.level6Array[1].item1
 }
```
fetching array item by index is safe
```swift
// this will do nothing
 var secondArrayItem_1_OfLevel_6:String?
 func dynamicMapping(mappingType: DynamicMappingType) {
    secondArrayItem_1_OfLevel_6 <--  ds.level1.level2.level3.level4.level5.level6Array[1200].item1
 }
```
You can access nested custom model as follows:
```swift
var level_6_Array:[ArrayItemModel]? 
func dynamicMapping(mappingType: DynamicMappingType) {
    level_6_Array  <--  ds.level1.level2.level3.level4.level5.level6Array
}

struct ArrayItemModel:DynamicCodable{
    var dynamicSelf:DynamicClass?
    
    var item1:String
    var item2:Int
    
    func dynamicMapping(mappingType: DynamicMappingType) {}
}
```

## Easy Json Insersion
Using the same Json above, You can insert any object or array same like when you access it

```swift
ds.level1.level2.level3.insertedProperty.set("nested item")
ds.level1.level2.insertedArray.set(["inserted item 1","inserted item 2"])
ds.level1.level2.level3.level4.level5.level6Array[4].set(ArrayItemModel(item1: "inserted item 1", item2: 5))
```
json will be 

```json
{
    "property0": "Value 0",
    "level1": {
        "property1": "Value 1",
        "level2": {
            "property2": 10,
            "insertedArray": [
             "inserted item 1",
             "inserted item 2"
            ],
            "level3": {
                "property3": "Value 3",
                "insertedProperty": "nested item",
                "level4": {
                    "property4": "Value 4",
                    "level5": {
                        "property5": "Value 5",
                        "level6Array": [
                            {
                                "item1": "Item A",
                                "item2": 100
                            },
                            {
                                "item1": "Item C",
                                "item2": 200
                            },
                            {
                                "item1": "Item E",
                                "item2": 300
                            },
                            {
                                "item1": "inserted item 1",
                                "item2": 5
                            }
                        ]
                    }
                }
            }
        }
    }
}
```
# Extend `JSONDecoder` & `JSONEncoder`
`DynamicJSONDecoder` and `DynamicJSONEncoder` inherit  `JSONDecoder` and `JSONEncoder` respectively, so they have the **full power** of native `Codable`
,for example date decoding 
```json
{
    "user":{
        "personalInfo":{
            "birthDate": "2023-10-30T19:00:00Z"
            .
            .
            .
        }
        .
        .
        .
    }
    .
    .
    .
}
```
```swift
 let decoder = DynamicJSONDecoder()
 decoder.dateDecodingStrategy = .iso8601
 
 var birthDate:Date?
 func dynamicMapping(mappingType: DynamicMappingType) {
     birthDate  <--  ds.user.personalInfo.birthDate
 }
```



# DynamicMapper + Realm

DynamicMapper and Realm can be used together

```swift
import RealmSwift
class Model: Object, DynamicCodable {
    var dynamicSelf:DynamicClass?
    
    @objc dynamic var name:String? = ""
    
    func dynamicMapping(mappingType: DynamicMappingType) {
        switch mappingType {
        case .decoding:
            name  <--  ds.user.personalInfo.name
        case .encoding:
            name  -->  {ds.user.personalInfo.name.set($0)}
        }
    }
}
```

# Contributing

Contributions are very welcome 👍😃. 

Before submitting any pull request, If you are including new functionality, please write test cases for it.

## Author

Abdulrahman Qasem, Abdulrahmanq1995@gmail.com

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Profile-informational?logo=linkedin)](https://www.linkedin.com/in/abdulrahmanqasem?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app)


## License

DynamicMapper is available under the MIT license. See the LICENSE file for more info.
