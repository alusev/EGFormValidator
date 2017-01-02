//
//  UITextFieldTests.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 02/01/17.
//  Copyright © 2017 Evgeny Gushchin. All rights reserved.
//

import XCTest
@testable import EGFormValidator

class UITextFieldTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testErrorDisplayable() {
        let conforms = (UITextField.self as Any) is Validatable.Type
        XCTAssert(conforms)
    }
    
    func testMethod() {
        let textField = UITextField()
        textField.text = "Some value"
        XCTAssertEqual(textField.text, textField.getValue() as? String)
    }

    
}
