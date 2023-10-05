//
//  JsonReader.swift
//  DynamicMapper_Example
//
//  Created by Abdulrahman Qasem on 05/10/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
class JsonReader{
    
    static func getJsonSample1Data()->Data{
        var data: Data = Data()
        guard let url = Bundle.main.url(forResource: "jsonExample", withExtension: "JSON") else {
            return data
        }
        do {
            data = try Data(contentsOf: url)
        } catch let error {
            print(error.localizedDescription)
        }
        return data
    }
}
