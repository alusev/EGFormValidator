//
//  ValidatorAlphaNumericTests.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 02/01/17.
//  Copyright © 2017 Evgeny Gushchin. All rights reserved.
//

import XCTest
@testable import EGFormValidator

class ValidatorAlphaNumericTests: XCTestCase {

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
        vc.addValidatorAlphaNumeric(toControl: textField, errorPlaceholder: placeholder, errorMessage: "Error")
        XCTAssert(vc.validate(), "Field is empty")

        textField.text = ""
        XCTAssert(vc.validate(), "Field is empty")

        textField.text = "01234567890"
        XCTAssert(vc.validate(), "Field has only digits")

        textField.text = "QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm"
        XCTAssert(vc.validate(), "Field has only letters")

        textField.text = "01890AxcE"
        XCTAssert(vc.validate(), "Field has only digits and letters")

        textField.text = "ñПриветЁ"
        XCTAssert(vc.validate(), "Field has only letters")

        textField.text = "Abc 123!"
        XCTAssertFalse(vc.validate(), "Field has non-alphanumeric characters")

        textField.text = "0xFFFF"
        XCTAssert(vc.validate(), "Field has only digits and letters")

        textField.text = "-3"
        XCTAssertFalse(vc.validate(), "Field has non-alphanumeric characters")
    }

    func testCondition0() {
        textField.text = "123abc!"
        vc.addValidatorAlphaNumeric(toControl: textField, errorPlaceholder: placeholder, errorMessage: "Error") { () -> Bool in
            return false
        }
        XCTAssert(vc.validate(), "Condition implies that the field is not required to contain only digits and letters")
    }

    func testCondition1() {
        textField.text = "123abc!"
        vc.addValidatorAlphaNumeric(toControl: textField, errorPlaceholder: placeholder, errorMessage: "Error") { () -> Bool in
            return true
        }
        XCTAssertFalse(vc.validate(), "Condition implies that the field must contain only digits and letters")
    }

}
