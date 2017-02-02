//
//  UITextViewTests.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 02/01/17.
//  Copyright © 2017 Evgeny Gushchin. All rights reserved.
//

import XCTest
@testable import EGFormValidator

class UITextViewTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testErrorDisplayable() {
        let conforms = (UITextView.self as Any) is Validatable.Type
        XCTAssert(conforms)
    }

    func testMethod() {
        let textView = UITextView()
        textView.text = "Some value"
        XCTAssertEqual(textView.text, textView.getValue() as? String)
    }

}
