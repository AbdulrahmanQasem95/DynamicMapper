//
//  DynamicValue.swift
//  DynamicMemberLookupTest
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation

@dynamicMemberLookup
public enum DynamicValue: Codable {
    
    case intValue(Int)
    case stringValue(String)
    case boolValue(Bool)
    case doubleValue(Double)
    case arrayValue(Array<DynamicValue>)
    case dictionaryValue(Dictionary<String, DynamicValue>)
    case null(Int?)
    
  
    public var stringValue: String? {
        if case .stringValue(let str) = self {
            return str
        }
        return nil
    }
    
    public var intValue: Int? {
        if case .intValue(let int) = self {
            return int
        }
        return nil
    }
    
    public var boolValue: Bool? {
        if case .boolValue(let bool) = self {
            return bool
        }
        return nil
    }
    
    public var doubleValue: Double? {
        if case .doubleValue(let double) = self {
            return double
        }
        return nil
    }
    
    public func arrayValue<T:DynamicDecodable>(customType:T.Type)-> [T] {
        if case .arrayValue(let value) = self {
            let data = try? JSONEncoder().encode(value)
            if let data = data {
                return (try? JSONDecoder().decode([T].self, from: data)) ?? []
            }
        }
        return []
    }
    
    public func objectValue<T:DynamicDecodable>(customType:T.Type)-> T? {
        if case .dictionaryValue(let value) = self {
            let data = try? JSONEncoder().encode(value)
            if let data = data {
                return (try? JSONDecoder().decode(T.self, from: data))
            }
        }
        return nil
    }
    
    public func arrayValue<T>(type:DynamicArrayValues)-> [T] {
        if case .arrayValue(let value) = self {
            switch type{
            case .int:
                return value.compactMap({$0.intValue}).map({$0  as! T})
            case .string:
                return value.compactMap({$0.stringValue}).map({$0  as! T})
            case .double:
                return value.compactMap({$0.doubleValue}).map({$0  as! T})
            case .bool:
                return value.compactMap({$0.boolValue}).map({$0  as! T})
            }
        }
        return []
    }
    
    public subscript(index: Int) -> DynamicValue? {
        get {
            if case .arrayValue(let arr) = self {
                return index < arr.count ? arr[index] : nil
            }
            return nil
        }
        set {
            if let newValue = newValue {
                if case .arrayValue(var arr) = self {
                    if index < arr.count {
                        arr[index] = newValue
                        self = .arrayValue(arr)
                    }
                }
            }
        }
    }
    
    public subscript(key: String) -> DynamicValue? {
        get {
            if case .dictionaryValue(let dict) = self {
                return dict[key]
            }
            return nil
        }
        set {
            if let newValue = newValue {
                if case .dictionaryValue(var dict) = self {
                     dict[key] = newValue
                    self = .dictionaryValue(dict)
                }
            }
        }
    }
    
    public subscript(dynamicMember member: String) -> DynamicValue? {
        get {
            if case .dictionaryValue(let dict) = self {
                return dict[member]
            }
            return nil
        }
        set {
            if let newValue = newValue {
                if case .dictionaryValue(var dict) = self {
                     dict[member] = newValue
                    self = .dictionaryValue(dict)
                }
            }

        }
    }
    
    
    public mutating func setDynamicProperty(value:Any) {
        switch value.self {
        case let string as String:
            self = .stringValue(string)
        case let int as Int:
            self = .intValue(int)
        case let bool as Bool:
            self = .boolValue(bool)
        case let double as Double:
            self = .doubleValue(double)
        case Optional<Any>.none:
            self = .null(nil)
        case is [Encodable]:
            print("Error in \(#function): object in array must conform to \(String(describing: DynamicEncodable.self)) protocol")
        default:
            print("Error in \(#function): object must conform to \(String(describing: DynamicEncodable.self)) protocol")
        }
    }
    
    public mutating func setDynamicProperty<T:DynamicEncodable>(customArray:[T]) {
        if let data =  try? JSONEncoder().encode(customArray) {
            if let model = try? JSONDecoder().decode([DynamicValue].self, from: data){
                self = .arrayValue(model)
            }
        }
    }
    
    public mutating func setDynamicProperty<T:DynamicEncodable>(customObject:T) {
        if let data =  try? JSONEncoder().encode(customObject) {
            if let model = try? JSONDecoder().decode([String:DynamicValue].self, from: data){
                self = .dictionaryValue(model)
            }
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let stringValue = try? container.decode(String.self) {
            self = .stringValue(stringValue)
        } else if let intValue = try? container.decode(Int.self) {
            self = .intValue(intValue)
        }else if let boolValue = try? container.decode(Bool.self) {
            self = .boolValue(boolValue)
        }else if let doubleValue = try? container.decode(Double.self) {
            self = .doubleValue(doubleValue)
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
        case .arrayValue(let array):
            try container.encode(array)
        case .dictionaryValue(let dictionary):
            try container.encode(dictionary)
        case .null(let null):
            try container.encode(null)
        }
    }
}


