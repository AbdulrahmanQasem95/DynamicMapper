//
//  Helper.swift
//  DynamicMapper_Example
//
//  Created by Abdulrahman Qasem on 07/11/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
class Helper {
    class func prettyPrint(data:Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("json data malformed")
        }
    }
}
