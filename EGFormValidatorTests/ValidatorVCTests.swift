//
//  ValidatorVCTests.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 02/01/17.
//  Copyright © 2017 Evgeny Gushchin. All rights reserved.
//

import XCTest
@testable import EGFormValidator

class ValidatorVCTests: XCTestCase {
    var vc: ValidatorViewController!
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = ValidatorViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testAdd0() {
        let validator = Validator(control: UITextField(), predicate: { (a, b) -> Bool in
            return true
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        
        vc.add(validator: validator)
        XCTAssert(vc.validate(), "Predicate return false but form is valid")
    }
    
    
    func testAdd1() {
        let validator = Validator(control: UITextField(), predicate: { (a, b) -> Bool in
            return false
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        
        vc.add(validator: validator)
        XCTAssertFalse(vc.validate(), "Predicate return true but form is invalid")
    }
    
    
    func testValidateSimple() {
        // Test empty form
        XCTAssert(vc.validate(), "A form without validators is invalid")
        
        
        // Test 1 field
        let validator1 = Validator(control: UITextField(), predicate: { (param1, param2) -> Bool in
            return true
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator1)
        XCTAssert(vc.validate(), "Predicate return true but form is invalid")

        
        // test 2 different fields
        let validator2 = Validator(control: UITextField(), predicate: { (param1, param2) -> Bool in
            return true
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator2)
        XCTAssert(vc.validate(), "Predicates return true but form is invalid")

        
        // test invalid field
        let validator3 = Validator(control: UITextField(), predicate: { (param1, param2) -> Bool in
            return false
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator3)
        XCTAssertFalse(vc.validate(), "One of the validators return false but form is valid")
    }
    
    
    
    func testValidateChained() {
        let control = UITextField()
        let errorPlaceholder = UILabel()
        
        // First passes
        let validator1 = Validator(control: control, predicate: { (param1, param2) -> Bool in
            return true
        }, predicateParameters: [], errorPlaceholder: errorPlaceholder, errorMessage: "")
        vc.add(validator: validator1)
        
        let validator2 = Validator(control: control, predicate: { (param1, param2) -> Bool in
            return false
        }, predicateParameters: [], errorPlaceholder: errorPlaceholder, errorMessage: "V2 ERROR")
        vc.add(validator: validator2)

        XCTAssertFalse(vc.validate(), "One of the validators return false but form is valid")
        XCTAssertEqual(errorPlaceholder.text ?? "", "V2 ERROR")

        
        // Third and forth are never executed
        let validator3 = Validator(control: control, predicate: { (param1, param2) -> Bool in
            return true
        }, predicateParameters: [], errorPlaceholder: errorPlaceholder, errorMessage: "")
        vc.add(validator: validator3)
        
        XCTAssertFalse(vc.validate(), "One of the validators return false but form is valid")
        XCTAssertEqual(errorPlaceholder.text ?? "", "V2 ERROR")
        
        
        let validator4 = Validator(control: control, predicate: { (param1, param2) -> Bool in
            return false
        }, predicateParameters: [], errorPlaceholder: errorPlaceholder, errorMessage: "V4 ERROR")
        vc.add(validator: validator4)
        XCTAssertFalse(vc.validate(), "One of the validators return false but form is valid")
        XCTAssertEqual(errorPlaceholder.text ?? "", "V2 ERROR")
    }
    

    func testFirstFailed0() {
        let validator1 = Validator(control: UITextField(), predicate: { (param1, param2) -> Bool in
            return false
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator1)
        
        XCTAssertNil(vc.firstFailedControl, "A not validated form has already a failed control")
    }
    

    func testFirstFailed1() {
        // form is valid
        let validator1 = Validator(control: UITextField(), predicate: { (param1, param2) -> Bool in
            return true
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator1)
        
        let validator2 = Validator(control: UITextField(), predicate: { (param1, param2) -> Bool in
            return true
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator2)
        
        XCTAssert(vc.validate(), "A form has only valid values")
        XCTAssertNil(vc.firstFailedControl, "A valid form has a failed control")
    }
    
    
    func testFirstFailed2() {
        // first added failed
        let firstControl = UITextField()
        firstControl.tag = 99
        
        let validator = Validator(control: firstControl, predicate: { (param1, param2) -> Bool in
            return false
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator)
        XCTAssertFalse(vc.validate(), "A form has just one but invalid field")
        
        XCTAssertNotNil(vc.firstFailedControl, "Failed control should not be empty because form has failed validation")
        XCTAssertEqual(firstControl.tag, vc.firstFailedControl?.tag)
    }
    
    
    func testFirstFailed3() {
        // several textfields
        let firstControl = UITextField()
        firstControl.tag = 99
        
        let validator1 = Validator(control: UITextField(), predicate: { (param1, param2) -> Bool in
            return true
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator1)
        
        let validator2 = Validator(control: firstControl, predicate: { (param1, param2) -> Bool in
            return false
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "V2 ERROR")
        vc.add(validator: validator2)
        
        let validator3 = Validator(control: UITextField(), predicate: { (param1, param2) -> Bool in
            return false
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "V3 ERROR")
        vc.add(validator: validator3)

        
        XCTAssertFalse(vc.validate(), "A form has 2 invalid fields")
        XCTAssertNotNil(vc.firstFailedControl, "Failed control should not be empty because form has failed validation")
        XCTAssertEqual(firstControl.tag, vc.firstFailedControl?.tag)
    }
    
    
    
    func testFirstFailed4() {
        // test chained
        let firstControl = UITextField()
        firstControl.tag = 99
        let errorPlaceholder = UILabel()
        
        // First passes
        let validator1 = Validator(control: firstControl, predicate: { (param1, param2) -> Bool in
            return true
        }, predicateParameters: [], errorPlaceholder: errorPlaceholder, errorMessage: "")
        vc.add(validator: validator1)
        
        let validator2 = Validator(control: firstControl, predicate: { (param1, param2) -> Bool in
            return false
        }, predicateParameters: [], errorPlaceholder: errorPlaceholder, errorMessage: "V2 ERROR")
        vc.add(validator: validator2)
        
        
        // Third and forth are never executed
        let validator3 = Validator(control: firstControl, predicate: { (param1, param2) -> Bool in
            return true
        }, predicateParameters: [], errorPlaceholder: errorPlaceholder, errorMessage: "")
        vc.add(validator: validator3)
        
        XCTAssertFalse(vc.validate(), "One of the validators return false but form is valid")
        XCTAssertNotNil(vc.firstFailedControl, "Failed control should not be empty because form has failed validation")
        XCTAssertEqual(firstControl.tag, vc.firstFailedControl?.tag)
    }
    

}
