//
//  URLBase.swift
//  marvelapp
//
//  Created by Alvaro Exposito on 29/11/20.
//

import Foundation

protocol UrlProtocol{
    func getUrl() -> String
}

///Enumerated to get the urls of the configuration PLIST files
enum UrlBase: String, UrlProtocol{
    
    case list = "LIST"
    case detail = "DETAIL"
    
    func getUrl() -> String {
        
        let dictionaryName = "MARVEL_API_URL"
        
        guard let urlDictionary = Bundle.main.object(forInfoDictionaryKey: dictionaryName) as? Dictionary<String,String> else { return "" }
        
        guard let url = urlDictionary[self.rawValue] else { return "" }
        
        return url
    }
}

/// Structure to create url from a base url and some parameters that can be entered anywhere in the url
struct UrlWithParameters: UrlProtocol {
    
    var url: UrlBase
    var params: [String]
    
    init(url: UrlBase, params: [String]) {
        self.url = url
        self.params = params
    }
    
    func getUrl() -> String {
        let concatUrl: String? = self.url.getUrl()
        return String(format: concatUrl ?? "", arguments: params)
    }
}

