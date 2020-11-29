//
//  AuthenticationTests.swift
//  AuthenticationTests
//
//  Created by Alvaro Exposito on 29/11/20.
//

import XCTest
@testable import marvelapp

class AuthenticationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //This Tests validates the Hash to Autenticate the API
    func testHashGenerator() throws {
        
        let hash = Authentication.generateHash(apiKey: "ABCD12345", timestamp: "123", privateKey: "12345ABCD")
                
        XCTAssert(hash == "d85ee984a92f84aa4ebd23f662aaea11")
    }

}
