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
    
    func testRetNil() {
        let control = CustomControlNil()
        XCTAssertNil(control.getValue())
        
        control.returnNil = true
        XCTAssertNil(control.getValue())

        control.returnNil = false
        XCTAssertNotNil(control.getValue())
    }
    
    
    func testValidator0() {
        vc.addValidatorEqualTo(toControl: textField1, errorPlaceholder: placeholder, errorMessage: "ERROR", compareWithControl: textField2)
        
        textField1.text = nil
        textField2.text = nil
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
        
        textField1.text = "yy"
        textField2.text = nil
        XCTAssertFalse(vc.validate(), "Fields are not equal")
        
        textField1.text = nil
        textField2.text = "xx"
        XCTAssertFalse(vc.validate(), "Fields are not equal")
        
        textField1.text = "1234"
        textField2.text = "12345"
        XCTAssertFalse(vc.validate(), "Fields arn't equal")
    }
    
    
    func testValidator1() {
        let customControl1 = CustomControl()
        let customControl2 = CustomControl()
        vc.addValidatorEqualTo(toControl: customControl1, errorPlaceholder: placeholder, errorMessage: "ERROR", compareWithControl: customControl2)
        
        customControl1.value = 10
        customControl2.value = 10
        XCTAssert(vc.validate(), "Fields are equal")
        
        customControl2.value = 20
        XCTAssertFalse(vc.validate(), "Fields are not equal")
    }
    
    
    
    func testValidator2() {
        let customControl1 = CustomControlFloat()
        let customControl2 = CustomControlFloat()
        vc.addValidatorEqualTo(toControl: customControl1, errorPlaceholder: placeholder, errorMessage: "ERROR", compareWithControl: customControl2)
        
        customControl1.value = 10.0
        customControl2.value = 10.0
        XCTAssert(vc.validate(), "Fields are equal")
        
        customControl2.value = 20
        XCTAssertFalse(vc.validate(), "Fields are not equal")
    }
    
    
    
    func testValidator3() {
        let customControl1 = CustomControlDouble()
        let customControl2 = CustomControlDouble()
        vc.addValidatorEqualTo(toControl: customControl1, errorPlaceholder: placeholder, errorMessage: "ERROR", compareWithControl: customControl2)
        
        customControl1.value = 10.0
        customControl2.value = 10.0
        XCTAssert(vc.validate(), "Fields are equal")
        
        customControl2.value = 20
        XCTAssertFalse(vc.validate(), "Fields are not equal")
    }
    
    
    
    func testValidator4() {
        let customControl1 = CustomControlCharacter()
        let customControl2 = CustomControlCharacter()
        vc.addValidatorEqualTo(toControl: customControl1, errorPlaceholder: placeholder, errorMessage: "ERROR", compareWithControl: customControl2)
        
        customControl1.value = "a"
        customControl2.value = "a"
        XCTAssert(vc.validate(), "Fields are equal")
        
        customControl2.value = "A"
        XCTAssertFalse(vc.validate(), "Fields are not equal")
    }

    
    func testValidator5() {
        let alwaysNil1 = CustomControlNil()
        let alwaysNil2 = CustomControlNil()
        vc.addValidatorEqualTo(toControl: alwaysNil1, errorPlaceholder: placeholder, errorMessage: "ERROR", compareWithControl: alwaysNil2)
        
        XCTAssert(vc.validate(), "Fields are not equal")
        
        alwaysNil1.returnNil = false
        XCTAssertFalse(vc.validate(), "Fields are equal")
        
        alwaysNil1.returnNil = true
        alwaysNil2.returnNil = false
        XCTAssertFalse(vc.validate(), "Fields are equal")
    }
    
    
    func testValidator6() {
        let customControl1 = CustomControlArray()
        let customControl2 = CustomControlArray()
        vc.addValidatorEqualTo(toControl: customControl1, errorPlaceholder: placeholder, errorMessage: "ERROR", compareWithControl: customControl2)
        
        XCTAssertFalse(vc.validate(), "Fields are of unknown type")
    }
    
    
    func testCondition0() {
        textField1.text = "12345"
        textField2.text = "1234"
        
        vc.addValidatorEqualTo(toControl: textField1, errorPlaceholder: placeholder, errorMessage: "ERROR", compareWithControl: textField2) { () -> Bool in
            return false
        }
        XCTAssert(vc.validate(), "Condition implies that the field is not required to be equal")
    }
    
    
    func testCondition1() {
        textField1.text = "12345"
        textField2.text = "1234"
        
        vc.addValidatorEqualTo(toControl: textField1, errorPlaceholder: placeholder, errorMessage: "ERROR", compareWithControl: textField2) { () -> Bool in
            return true
        }
        XCTAssertFalse(vc.validate(), "Condition implies that the field must be equal")
    }

}

class CustomControlFloat: UIView, Validatable {
    var value: Float?
    
    func getValue() -> Any? {
        return value
    }
}

class CustomControlDouble: UIView, Validatable {
    var value: Double?
    
    func getValue() -> Any? {
        return value
    }
}


class CustomControlCharacter: UIView, Validatable {
    var value: Character?
    
    func getValue() -> Any? {
        return value
    }
}

class CustomControlNil: UIView, Validatable {
    var returnNil: Bool = true
    
    func getValue() -> Any? {
        return returnNil ? nil : "not nil value"
    }
}


class CustomControlArray: UIView, Validatable {
    func getValue() -> Any? {
        return ["array"]
    }
}
