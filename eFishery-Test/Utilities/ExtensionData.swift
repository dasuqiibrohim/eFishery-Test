//
//  ExtensionData.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import Foundation

extension Data {
    func decodeTo<T: Codable>(_ type: T.Type) -> T? {
        do {
            let result = try JSONDecoder().decode(T.self, from: self)
            return result
        } catch let DecodingError.dataCorrupted(context) {
            #if DEVELOPMENT
            print(context)
            #endif
            return nil
        } catch let DecodingError.keyNotFound(key, context) {
            #if DEVELOPMENT
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            #endif
            return nil
        } catch let DecodingError.valueNotFound(value, context) {
            #if DEVELOPMENT
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            #endif
            return nil
        } catch let DecodingError.typeMismatch(type, context)  {
            #if DEVELOPMENT
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            #endif
            return nil
        } catch {
            print("error: ", error)
            return nil
        }
    }
}
