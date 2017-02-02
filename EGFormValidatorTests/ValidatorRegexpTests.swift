//
//  ValidatorRegexpTests.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 08/01/17.
//  Copyright © 2017 Evgeny Gushchin. All rights reserved.
//

import XCTest
@testable import EGFormValidator

class ValidatorRegexpTests: XCTestCase {
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
        vc.addValidatorRegexp(toControl: textField,
                       errorPlaceholder: placeholder,
                           errorMessage: "ERROR",
                                pattern: "^a910")
        XCTAssertFalse(vc.validate())

        textField.text = "a910xxxxx"
        XCTAssert(vc.validate())
    }

    func testValidator1() {
        textField.text = "+79601234567"
        vc.addValidatorRegexp(toControl: textField,
                              errorPlaceholder: placeholder,
                              errorMessage: "ERROR",
                              pattern: "^(8|\\+7)\\d{10}$")
        XCTAssert(vc.validate())

        textField.text = "89601234567"
        XCTAssert(vc.validate())
    }

}
