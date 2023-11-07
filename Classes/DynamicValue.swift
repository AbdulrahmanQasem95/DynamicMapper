//
//  DynamicValue.swift
//  DynamicMapper
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation

@dynamicMemberLookup
public enum DynamicValue: Codable {
    
    case stringValue(String)
    case intValue(Int)
    case boolValue(Bool)
    case doubleValue(Double)
    case floatValue(Float)
    case dateValue(Date,String?)
    case dataValue(Data)
    case urlValue(URL)
    case arrayValue(Array<DynamicValue>)
    case dictionaryValue(Dictionary<String, DynamicValue>)
    case null(Int?)
    
    //string value
     var stringValue: String? {
        if case .stringValue(let str) = self {
            return str
        }else if case .dateValue(_, let originalString) = self {
            return originalString
        }
        return nil
    }
    
    //Integer value
     var intValue: Int? {
        if case .intValue(let int) = self {
            return int
        }
        return nil
    }
    
    //Boolean value
     var boolValue: Bool? {
        if case .boolValue(let bool) = self {
            return bool
        }
        return nil
    }
    
    //Double value
     var doubleValue: Double? {
        if case .doubleValue(let double) = self {
            return double
        }
        return nil
    }
    
    //Float value
     var floatValue: Float? {
        if case .floatValue(let float) = self {
            return float
        }else if case .doubleValue(let double) = self {
            return Float(double)
        }
        return nil
    }
    
    //Date value
     var dateValue: Date? {
        if case .dateValue(let date,_) = self {
            return date
        }
        return nil
    }
    
    //Data value
     var dataValue: Data? {
        if case .dataValue(let data) = self {
            return data
        }
        return nil
    }
    
    //URL value
     var urlValue: URL? {
        if case .urlValue(let url) = self {
            return url
        }else if case .stringValue(let string) = self {
            return URL(string: string)
        }
        return nil
    }
    
    //Custom object conform to DynamicDecodable protocol
      func objectValue<T:DynamicDecodable>(customType:T.Type)-> T? {
        if case .dictionaryValue(let value) = self {
            let data = try? JSONEncoder().encode(value)
            if let data = data {
                if let model = try? DynamicJSONDecoder().decode(T.self, from: data) {
                    return (model)
                }
            }
        }
        return nil
    }
    
    //Array of Integers
      func intArrayValue()-> [Int] {
        if case .arrayValue(let value) = self {
            return value.compactMap({$0.intValue}).map({$0  })
        }
        return []
    }
    
    //Array of Strings
      func stringArrayValue()-> [String] {
        if case .arrayValue(let value) = self {
            return value.compactMap({$0.stringValue}).map({$0  })
        }
        return []
    }
    
    //Array of Booleans
      func boolArrayValue()-> [Bool] {
        if case .arrayValue(let value) = self {
            return value.compactMap({$0.boolValue}).map({$0  })
        }
        return []
    }
    
    //Array of Doubles
      func doubleArrayValue()-> [Double] {
        if case .arrayValue(let value) = self {
            return value.compactMap({$0.doubleValue}).map({$0  })
        }
        return []
    }
    
    //Array of Floats
      func floatArrayValue()-> [Float] {
        if case .arrayValue(let value) = self {
            return value.compactMap({$0.floatValue}).map({$0  })
        }
        return []
    }
    
    //Array of Dates
      func dateArrayValue()-> [Date] {
        if case .arrayValue(let value) = self {
            return value.compactMap({$0.dateValue}).map({$0  })
        }
        return []
    }
    
    //Array of Data
      func dataArrayValue()-> [Data] {
        if case .arrayValue(let value) = self {
            return value.compactMap({$0.dataValue}).map({$0  })
        }
        return []
    }
    
    //Array of URLs
      func urlArrayValue()-> [URL] {
        if case .arrayValue(let value) = self {
            return value.compactMap({$0.urlValue}).map({$0  })
        }
        return []
    }
    
    //Array of custom objects that confrom to DynamicDecodable
      func customArrayValue<T:DynamicDecodable>(type:T.Type)-> [T] {
        if case .arrayValue(let value) = self {
            let data = try? JSONEncoder().encode(value)
            if let data = data {
                //TODO: test and validate this
                if let model = try?  DynamicJSONDecoder().decode([T].self, from: data) {
                    return model
                }
            }
        }
        return []
    }
    
    //Safe access of array item by index
    public subscript(index: Int) -> DynamicValue {
        mutating get {
            if case .arrayValue(var arr) = self {
                if index < arr.count {
                   return arr[index]
                }else {
                    arr.append(.dictionaryValue([:]))
                    self = .arrayValue(arr)
                    return self
                }
            }else {
                var arr:[DynamicValue] = []
                self = .arrayValue(arr)
                return self
            }
        }
        set {
           // if let newValue = newValue {
                if case .arrayValue(var arr) = self {
                    if index < arr.count {
                        arr[index] = newValue
                        self = .arrayValue(arr)
                    }else{
                        arr.append(newValue)
                        self = .arrayValue(arr)
                    }
                }
            //}
        }
    }
    
    //     subscript(key: String) -> DynamicValue? {
    //        get {
    //            if case .dictionaryValue(let dict) = self {
    //                return dict[key]
    //            }
    //
    //
    //            return nil
    //        }
    //        set {
    //            if let newValue = newValue {
    //                if case .dictionaryValue(var dict) = self {
    //                     dict[key] = newValue
    //                    self = .dictionaryValue(dict)
    //                }
    //            }
    //        }
    //    }
    
    // Dynamic member lookup subscript
    public subscript(dynamicMember member: String) -> DynamicValue {
        mutating get {
            if case .dictionaryValue(var  dict) = self {
                if let value =  dict[member] {
                    return value
                }else {
                    let newDic =  DynamicValue.dictionaryValue([:])
                    dict[member] = newDic
                    self = newDic
                    return self
                }
            } else {
                let newDic =  DynamicValue.dictionaryValue([:])
                self = newDic
                return self
            }
        }
        
        set {
           // if let newValue = newValue {
                if case .dictionaryValue(var dict) = self {
                    dict[member] = newValue
                    self = .dictionaryValue(dict)
                }
            //}
        }
    }
   
    //MARK: - Set Value
    // set any value (Integer, String, Boolean, Double, null)
    public mutating func set(_ value:Any?) {
        switch value.self {
        case let date as Date:
            // save string to null, if user set value as Date he should get it as Date also
            self = .dateValue(date,nil)
        case let url as URL:
            self = .urlValue(url)
        case let string as String:
            self = .stringValue(string)
        case let int as Int:
            self = .intValue(int)
        case let bool as Bool:
            self = .boolValue(bool)
        case let float as Float:
            self = .floatValue(float)
        case let double as Double:
            self = .doubleValue(double)
        case let data as Data:
            self = .dataValue(data)
        case Optional<Any>.none:
            self = .null(nil)
        case is [Encodable]:
            print("Error in \(#function): object in array must conform to \(String(describing: DynamicEncodable.self)) protocol")
        default:
            print("Error in \(#function): object must conform to \(String(describing: DynamicEncodable.self)) protocol")
        }
    }
    
    
    //set array of custom object that conform to DynamicEncodable protocol
    public mutating func set<T:DynamicEncodable>(_ customObject:T?) {
        if let data =  try? JSONEncoder().encode(customObject) {
            if let model = try? JSONDecoder().decode([String:DynamicValue].self, from: data){
                self = .dictionaryValue(model)
            }
        }
    }
    
    //set custom object that conform to "Encodable" not "DynamicEncodable" protocol
    //this will work for all custom objects and Dynamic value supported types arrays [string,int,date .....]
    public mutating func set<T:Encodable>(_ customArray:[T]?) {
        if let data =  try? JSONEncoder().encode(customArray) {
            if let model = try? JSONDecoder().decode([DynamicValue].self, from: data){
                self = .arrayValue(model)
            }
        }
    }
    
    // decoding
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        // conditions order is important
         if let dateValue = try? container.decode(Date.self) {
             self = .dateValue(dateValue, try? container.decode(String.self))
        }else if let stringValue = try? container.decode(String.self) {
            // used for String, URL
            self = .stringValue(stringValue)
        } else if let intValue = try? container.decode(Int.self) {
            self = .intValue(intValue)
        }else if let boolValue = try? container.decode(Bool.self) {
            self = .boolValue(boolValue)
        }else if let doubleValue = try? container.decode(Double.self) {
            // used for Double, Float
            self = .doubleValue(doubleValue)
        }else if let dataValue = try? container.decode(Data.self) {
            self = .dataValue(dataValue)
        }else if let arrayValue = try? container.decode(Array<DynamicValue>.self) {
            self = .arrayValue(arrayValue)
        } else if let dictionaryValue = try? container.decode(Dictionary<String, DynamicValue>.self) {
            self = .dictionaryValue(dictionaryValue)
        }else {
            let null = try? container.decode(Int?.self)
            if null == nil {
                self = .null(nil)
            }else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Value cannot be decoded")
            }
        }
    }
    
    // encoding
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .stringValue(let string):
            try container.encode(string)
        case .intValue(let int):
            try container.encode(int)
        case .boolValue(let bool):
            try container.encode(bool)
        case .doubleValue(let double):
            try container.encode(double)
        case .floatValue(let float):
            try container.encode(float)
        case .dateValue(let date, _):
            try container.encode(date)
        case .dataValue(let data):
            try container.encode(data)
        case .urlValue(let url):
            try container.encode(url)
        case .arrayValue(let array):
            try container.encode(array)
        case .dictionaryValue(let dictionary):
            try container.encode(dictionary)
        case .null(let null):
            try container.encode(null)
        }
    }
}


