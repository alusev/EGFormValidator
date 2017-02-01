//
//  ValidatorDigitsOnlyTests.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 02/01/17.
//  Copyright © 2017 Evgeny Gushchin. All rights reserved.
//

import XCTest
@testable import EGFormValidator

class ValidatorDigitsOnlyTests: XCTestCase {

    var vc: ValidatorViewController!
    var textField: UITextField!
    var placeholder: UILabel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = ValidatorViewController()
        textField = UITextField()
        placeholder = UILabel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testValidator() {
        vc.addValidatorDigitsOnly(toControl: textField, errorPlaceholder: placeholder, errorMessage: "Error")
        XCTAssert(vc.validate(), "Field is empty")
        
        textField.text = ""
        XCTAssert(vc.validate(), "Field is empty")
        
        textField.text = "abc"
        XCTAssertFalse(vc.validate(), "Field has non-digits")
        
        textField.text = "AB,C"
        XCTAssertFalse(vc.validate(), "Field has non-digits")
        
        textField.text = "01234567890"
        XCTAssert(vc.validate(), "Field has only digits")
        
        textField.text = "000aaa"
        XCTAssertFalse(vc.validate(), "Field has non-digits")
        
        textField.text = "0.5"
        XCTAssertFalse(vc.validate(), "Field has non-digits")
        
        textField.text = "100,000"
        XCTAssertFalse(vc.validate(), "Field has non-digits")
    }
    
    
    func testCondition0() {
        textField.text = "abc"
        vc.addValidatorDigitsOnly(toControl: textField, errorPlaceholder: placeholder, errorMessage: "Error") { () -> Bool in
            return false
        }
        XCTAssert(vc.validate(), "Condition implies that the field is not required to contain only digits")
    }
    
    
    func testCondition1() {
        textField.text = "abc"
        vc.addValidatorDigitsOnly(toControl: textField, errorPlaceholder: placeholder, errorMessage: "Error") { () -> Bool in
            return true
        }
        XCTAssertFalse(vc.validate(), "Condition implies that the field must contain only digits")
    }
    
}
