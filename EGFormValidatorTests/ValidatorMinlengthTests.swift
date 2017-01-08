//
//  ValidatorMinlengthTests.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 02/01/17.
//  Copyright © 2017 Evgeny Gushchin. All rights reserved.
//

import XCTest
@testable import EGFormValidator

class ValidatorMinlengthTests: XCTestCase {
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
    
    func testValidator0() {
        textField.text = ""
        vc.addValidatorMinLength(toControl: textField, errorPlaceholder: placeholder, errorMessage: "ERROR", minLength: 10)
        XCTAssert(vc.validate(), "Field is mandatory")
    }
    
    
    func testValidator1() {
        textField.text = nil
        vc.addValidatorMinLength(toControl: textField, errorPlaceholder: placeholder, errorMessage: "ERROR", minLength: 10)
        XCTAssert(vc.validate(), "Field is mandatory")
    }
    
    
    func testValidator2() {
        textField.text = "12"
        vc.addValidatorMinLength(toControl: textField, errorPlaceholder: placeholder, errorMessage: "ERROR", minLength: 3)
        XCTAssertFalse(vc.validate(), "A values has less characters")
    }
    
    
    func testValidator3() {
        textField.text = "123"
        vc.addValidatorMinLength(toControl: textField, errorPlaceholder: placeholder, errorMessage: "ERROR", minLength: 3)
        XCTAssert(vc.validate(), "A values has enough characters")
    }
    
    
    func testValidator4() {
        textField.text = "1234"
        vc.addValidatorMinLength(toControl: textField, errorPlaceholder: placeholder, errorMessage: "ERROR", minLength: 3)
        XCTAssert(vc.validate(), "A values has more than enough characters")
    }
    
    
    
    func testCondition0() {
        textField.text = "123"
        vc.addValidatorMinLength(toControl: textField, errorPlaceholder: placeholder, errorMessage: "ERROR", minLength: 3) { () -> Bool in
            return false
        }
        XCTAssert(vc.validate(), "Condition implies that the field is not required to have at least 3 characters")
        
    }
    
    
    func testCondition1() {
        textField.text = "12"
        vc.addValidatorMinLength(toControl: textField, errorPlaceholder: placeholder, errorMessage: "ERROR", minLength: 3) { () -> Bool in
            return true
        }
        XCTAssertFalse(vc.validate(), "Condition implies that the field must have at least 3 characters")
    }
}
