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
        textField.limitLength(textField: textField)
        XCTAssertEqual(textField.text?.count, 3)

        textField.text = "qwert"
        textField.limitLength(textField: textField)
        XCTAssertEqual(textField.text?.count, 5)

        textField.text = "qwerty"
        textField.limitLength(textField: textField)
        XCTAssertEqual(textField.text?.count, 5)

        // test getter
        textField.maxLength = 15
        textField.limitLength(textField: textField)
        XCTAssertEqual(textField.maxLength, 15)
    }

}
