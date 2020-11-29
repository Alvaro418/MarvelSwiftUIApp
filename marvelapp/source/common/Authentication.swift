//
//  Authentication.swift
//  marvelapp
//
//  Created by Alvaro Exposito on 25/11/2020.
//

import Foundation
import CryptoKit

/// Class in charge of handling the API authentication hash
class Authentication {
    
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    static let timestamp = Bundle.main.object(forInfoDictionaryKey: "TIMESTAMP") as? String
    static let privateKey = Bundle.main.object(forInfoDictionaryKey: "PRIVATE_KEY") as? String
    
    fileprivate static func generateHash(apiKey: String, timestamp: String, privateKey: String) -> String {
        
        let stringToHash = timestamp + privateKey + apiKey
        
        let digest = Insecure.MD5.hash(data: stringToHash.data(using: .utf8) ?? Data())
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
    
    /// Generator of standard authentication parameters
    /// - Returns:List of URLQueryItem to authenticate
    static func generateHeaders() -> [URLQueryItem] {
        
        guard let apiKey = Authentication.apiKey, !apiKey.isEmpty else {
            print("<ERROR> You must to introduce an API KEY in the plis file.")
            return []
        }
        
        guard let timestamp = Authentication.timestamp, !timestamp.isEmpty else {
            print("<ERROR> You must to introduce a Timestamp in the plis file.")
            return []
        }
        
        guard let privateKey = Authentication.privateKey, !privateKey.isEmpty else {
            print("<ERROR> You must to introduce a Private Key in the plis file.")
            return []
        }
        
        var queryItemList : [URLQueryItem] = []
        queryItemList.append(URLQueryItem(name: "apikey", value: apiKey))
        queryItemList.append(URLQueryItem(name: "ts", value: timestamp))
        queryItemList.append(URLQueryItem(name: "hash", value: generateHash(apiKey: apiKey,
                                                                            timestamp: timestamp,
                                                                            privateKey: privateKey)))
        
        return queryItemList
    }
}



