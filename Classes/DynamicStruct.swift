//
//  DynamicStruct.swift
//  DynamicMemberLookupTest
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

//import Foundation
//
//@dynamicMemberLookup
//public struct DynamicStruct: DynamicCodable {
//    public var dynamicSelf: DynamicClass?
//    
//    public func fetchNestedItems() {
//        fatalError("This method must be overriden by subclass in order to set the nested parameters")
//    }
//    struct DynamicCodingKeys: CodingKey {
//        var stringValue: String
//        init?(stringValue: String) {
//            self.stringValue = stringValue
//        }
//        var intValue: Int?
//        init?(intValue: Int) {
//            self.intValue = intValue
//            self.stringValue = "\(intValue)"
//        }
//    }
//
//    private var container: [String: DynamicValue]
//
//    init(_ dictionary: [String: DynamicValue]) {
//        self.container = dictionary
//        //dynamicValue = DynamicValue(from: Decoder())
//    }
//
//    // Dynamic member lookup subscript
//    subscript(dynamicMember key: String) -> DynamicValue? {
//        return container[key]
//    }
//
//    // Codable methods
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
//        var tempContainer = [String: DynamicValue]()
//        for key in container.allKeys {
//            let stringValue = key.stringValue
//                let dynamicValue = try container.decode(DynamicValue.self, forKey: key)
//                tempContainer[stringValue] = dynamicValue
//            
//        }
//        self.container = tempContainer
//        //dynamicValue = self
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: DynamicCodingKeys.self)
//        for (key, value) in self.container {
//            let dynamicKey = DynamicCodingKeys(stringValue: key)!
//            try container.encode(value, forKey: dynamicKey)
//        }
//    }
//}
//
