//
//  DynamicClass.swift
//  DynamicMapper
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation

@dynamicMemberLookup
open class DynamicClass: Codable {
    
    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = "\(intValue)"
        }
    }
    
    private var container: [String: DynamicValue]
    
    init(_ dictionary: [String: DynamicValue]) {
        self.container = dictionary
    }
    
    // Dynamic member lookup subscript
    public subscript(dynamicMember key: String) -> DynamicValue {
        get {
            if let value = container[key] {
                return value
            }
            else {
                // create value if not exist - Json Generation or Insertion-
                container[key] = .dictionaryValue([:])
                return container[key]!
            }
        }
        set {
            container[key] = newValue
        }
    }
    
    // Decoding
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var tempContainer = [String: DynamicValue]()
        for key in container.allKeys {
            let stringValue = key.stringValue
            let dynamicValue = try container.decode(DynamicValue.self, forKey: key)
            tempContainer[stringValue] = dynamicValue
        }
        self.container = tempContainer
    }
    
    //Encoding
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DynamicCodingKeys.self)
        for (key, value) in self.container {
            let dynamicKey = DynamicCodingKeys(stringValue: key)!
            try container.encode(value, forKey: dynamicKey)
        }
    }
}
