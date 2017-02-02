//
//  ValidatorEmailTests.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 02/01/17.
//  Copyright © 2017 Evgeny Gushchin. All rights reserved.
//

import XCTest
@testable import EGFormValidator

class ValidatorEmailTests: XCTestCase {
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
        vc.addValidatorEmail(toControl: textField, errorPlaceholder: placeholder, errorMessage: "ERROR")
        XCTAssert(vc.validate(), "Email is mandatory")
    }

    func testValidator1() {
        textField.text = nil
        vc.addValidatorEmail(toControl: textField, errorPlaceholder: placeholder, errorMessage: "ERROR")
        XCTAssert(vc.validate(), "Email is mandatory")
    }

    func testValidator2() {
        textField.text = "xxx"
        vc.addValidatorEmail(toControl: textField, errorPlaceholder: placeholder, errorMessage: "ERROR")
        XCTAssertFalse(vc.validate(), "Email is invalid")
    }

    func testValidator3() {
        textField.text = "xxx@yyy.zzz"
        vc.addValidatorEmail(toControl: textField, errorPlaceholder: placeholder, errorMessage: "ERROR")
        XCTAssert(vc.validate(), "Email is valid")
    }
    
    func testCondition0() {
        textField.text = "xxx"
        vc.addValidatorEmail(toControl: textField, errorPlaceholder: placeholder, errorMessage: "ERROR") { () -> Bool in
            return false
        }
        XCTAssert(vc.validate(), "Condition implies that the field is not required to be a valid email")
    }

    func testCondition1() {
        textField.text = "12"
        vc.addValidatorEmail(toControl: textField, errorPlaceholder: placeholder, errorMessage: "ERROR") { () -> Bool in
            return true
        }
        XCTAssertFalse(vc.validate(), "Condition implies that the field must be an email")
    }
}
