//
//  EmailTests.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 02/01/17.
//  Copyright © 2017 Evgeny Gushchin. All rights reserved.
//

import XCTest
@testable import EGFormValidator

class EmailTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStringEmail() {
        XCTAssert("abc@gmail.com".isValidEmail())
        XCTAssert("abc@gmail.com.mx".isValidEmail())
        XCTAssert("1abc@gmail.com.mx".isValidEmail())
        XCTAssert("1ab.c@gmail.com.mx".isValidEmail())
        XCTAssert("a@gmail.com.mx".isValidEmail())
        XCTAssert("a@ab.cd".isValidEmail())
        XCTAssertFalse("abc@localhost".isValidEmail())
        XCTAssertFalse("ab@c@localho.st".isValidEmail())
        XCTAssert("a@gmail.travel".isValidEmail())
        XCTAssert("a-b@gma-i1234l.com.mx".isValidEmail())
        XCTAssert("a-b@123gma-i1234l.com.mx".isValidEmail())
        XCTAssertFalse("".isValidEmail())
    }
    
}
