//
//  ValidatorMaxlengthTests.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 02/01/17.
//  Copyright © 2017 Evgeny Gushchin. All rights reserved.
//

import XCTest
@testable import EGFormValidator

class ValidatorMaxlengthTests: XCTestCase {
    var textField: UITextField!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        textField = UITextField()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testDefaultValue() {
        XCTAssertEqual(Int.max, textField.maxLength, "Default value is too short")
    }
    
    
    func testMaxlength() {
        textField.maxLength = 5
        textField.text = "qwe"
        XCTAssertEqual(textField.text?.characters.count, 3)
        
        textField.maxLength = 5
        textField.text = "qwert"
        XCTAssertEqual(textField.text?.characters.count, 5)
        
        textField.maxLength = 5
        textField.text = "qwerty"
        XCTAssertEqual(textField.text?.characters.count, 6)
        
        // test getter
        textField.maxLength = 15
        XCTAssertEqual(textField.maxLength, 15)
    }
    
    // TODO: add UI tests
}
