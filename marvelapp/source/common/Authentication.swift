//
//  Authentication.swift
//  marvelapp
//
//  Created by Alvaro Exposito on 25/11/2020.
//

import Foundation
import CryptoKit

class Authentication {
 
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    static let timestamp = Bundle.main.object(forInfoDictionaryKey: "TIMESTAMP") as? String
    static let privateKey = Bundle.main.object(forInfoDictionaryKey: "PRIVATE_KEY") as? String

    
    static func generateHash(apiKey: String) -> String {
        
        guard let timestamp = Authentication.timestamp, !timestamp.isEmpty else {
            print("<ERROR> You must to introduce a Timestamp in the plis file.")
            return ""
        }

        guard let privateKey = Authentication.privateKey, !privateKey.isEmpty else {
            print("<ERROR> You must to introduce a Private Key in the plis file.")
            return ""
        }


        let stringToHash = timestamp + privateKey + apiKey
                
        let digest = Insecure.MD5.hash(data: stringToHash.data(using: .utf8) ?? Data())
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }

    static func generateHeaders() -> String {
        
        guard let apiKey = Authentication.apiKey, !apiKey.isEmpty else {
            print("<ERROR> You must to introduce an API KEY in the plis file.")
            return ""
        }

        return "?apikey=\(apiKey)&ts=1&hash=\(generateHash(apiKey: apiKey))"
    }
}


    
