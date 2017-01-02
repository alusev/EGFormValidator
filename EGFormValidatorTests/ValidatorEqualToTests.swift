//
//  ValidatorEqualToTests.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 02/01/17.
//  Copyright © 2017 Evgeny Gushchin. All rights reserved.
//

import XCTest
@testable import EGFormValidator

class ValidatorEqualToTests: XCTestCase {
    var vc: ValidatorViewController!
    var textField1: UITextField!
    var textField2: UITextField!
    var placeholder: UILabel!
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = ValidatorViewController()
        textField1 = UITextField()
        textField2 = UITextField()
        placeholder = UILabel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testValidator() {
        vc.addValidatorEqualTo(toControl: textField1, errorPlaceholder: placeholder, errorMessage: "ERROR", compareWithControl: textField2)
        XCTAssert(vc.validate(), "Fields are equal")
        
        textField1.text = ""
        textField2.text = ""
        XCTAssert(vc.validate(), "Fields are equal")
        
        textField1.text = "1234"
        textField2.text = "1234"
        XCTAssert(vc.validate(), "Fields are equal")
        
        textField1.text = ""
        textField2.text = nil
        XCTAssert(vc.validate(), "Fields are equal")
        
        textField1.text = "1234"
        textField2.text = "12345"
        XCTAssertFalse(vc.validate(), "Fields arn't equal")
    }
    
}
