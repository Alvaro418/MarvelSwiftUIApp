//
//  URLTests.swift
//  URLTests
//
//  Created by Alvaro Exposito on 29/11/20.
//

import XCTest
@testable import marvelapp

class URLTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURLWithParams() throws {


        let url = UrlWithParameters.init(url: .detail, params: ["AAAA"])

        XCTAssert(url.getUrl() == "https://gateway.marvel.com/v1/public/characters/AAAA")
    }


}
