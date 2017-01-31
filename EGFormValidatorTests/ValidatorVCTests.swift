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
    
    let validatorPredicateTrue: ValidatorPredicate = { (param1, param2) -> Bool in
        return true
    }
    
    let validatorPredicateFalse: ValidatorPredicate = { (param1, param2) -> Bool in
        return false
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = ValidatorViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidatorPredicates() {
        XCTAssert(validatorPredicateTrue(nil, [nil]))
        XCTAssertFalse(validatorPredicateFalse(nil, [nil]))
    }
    
    
    func testAdd0() {
        let validator = Validator(control: UITextField(), predicate: validatorPredicateTrue, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        
        vc.add(validator: validator)
        XCTAssert(vc.validate(), "Predicate return false but form is valid")
    }
    
    
    func testAdd1() {
        let validator = Validator(control: UITextField(), predicate: validatorPredicateFalse, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        
        vc.add(validator: validator)
        XCTAssertFalse(vc.validate(), "Predicate return true but form is invalid")
    }
    
    
    func testValidateSimple() {
        // Test empty form
        XCTAssert(vc.validate(), "A form without validators is invalid")
        
        
        // Test 1 field
        let validator1 = Validator(control: UITextField(), predicate: validatorPredicateTrue, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator1)
        XCTAssert(vc.validate(), "Predicate return true but form is invalid")

        
        // test 2 different fields
        let validator2 = Validator(control: UITextField(), predicate: validatorPredicateTrue, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator2)
        XCTAssert(vc.validate(), "Predicates return true but form is invalid")

        
        // test invalid field
        let validator3 = Validator(control: UITextField(), predicate: validatorPredicateFalse, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator3)
        XCTAssertFalse(vc.validate(), "One of the validators return false but form is valid")
    }
    
    
    
    func testValidateChained() {
        let control = UITextField()
        let errorPlaceholder = UILabel()
        
        // First passes
        let validator1 = Validator(control: control, predicate: validatorPredicateTrue, predicateParameters: [], errorPlaceholder: errorPlaceholder, errorMessage: "")
        vc.add(validator: validator1)
        
        let validator2 = Validator(control: control, predicate: validatorPredicateFalse, predicateParameters: [], errorPlaceholder: errorPlaceholder, errorMessage: "V2 ERROR")
        vc.add(validator: validator2)

        XCTAssertFalse(vc.validate(), "One of the validators return false but form is valid")
        XCTAssertEqual(errorPlaceholder.text ?? "", "V2 ERROR")

        
        // Third and forth are never executed
        XCTAssert(validatorPredicateTrue(nil, [nil]))
        
        let validator3 = Validator(control: control, predicate: validatorPredicateTrue, predicateParameters: [], errorPlaceholder: errorPlaceholder, errorMessage: "")
        vc.add(validator: validator3)
        
        XCTAssertFalse(vc.validate(), "One of the validators return false but form is valid")
        XCTAssertEqual(errorPlaceholder.text ?? "", "V2 ERROR")
        
        
        
        let validator4 = Validator(control: control, predicate: validatorPredicateFalse, predicateParameters: [], errorPlaceholder: errorPlaceholder, errorMessage: "V4 ERROR")
        vc.add(validator: validator4)
        XCTAssertFalse(vc.validate(), "One of the validators return false but form is valid")
        XCTAssertEqual(errorPlaceholder.text ?? "", "V2 ERROR")
    }
    

    func testFirstFailed0() {
        let validator1 = Validator(control: UITextField(), predicate: validatorPredicateFalse, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator1)
        
        XCTAssertNil(vc.firstFailedControl, "A not validated form has already a failed control")
    }
    

    func testFirstFailed1() {
        // form is valid
        let validator1 = Validator(control: UITextField(), predicate: validatorPredicateTrue, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator1)
        
        let validator2 = Validator(control: UITextField(), predicate: validatorPredicateTrue, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator2)
        
        XCTAssert(vc.validate(), "A form has only valid values")
        XCTAssertNil(vc.firstFailedControl, "A valid form has a failed control")
    }
    
    
    func testFirstFailed2() {
        // first added failed
        let firstControl = UITextField()
        firstControl.tag = 99
        
        let validator = Validator(control: firstControl, predicate: validatorPredicateFalse, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator)
        XCTAssertFalse(vc.validate(), "A form has just one but invalid field")
        
        XCTAssertNotNil(vc.firstFailedControl, "Failed control should not be empty because form has failed validation")
        XCTAssertEqual(firstControl.tag, vc.firstFailedControl?.tag)
    }
    
    
    func testFirstFailed3() {
        // several textfields
        let firstControl = UITextField()
        firstControl.tag = 99
        
        let validator1 = Validator(control: UITextField(), predicate: validatorPredicateTrue, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        vc.add(validator: validator1)
        
        let validator2 = Validator(control: firstControl, predicate: validatorPredicateFalse, predicateParameters: [], errorPlaceholder: nil, errorMessage: "V2 ERROR")
        vc.add(validator: validator2)
        
        let validator3 = Validator(control: UITextField(), predicate: validatorPredicateFalse, predicateParameters: [], errorPlaceholder: nil, errorMessage: "V3 ERROR")
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
        let validator1 = Validator(control: firstControl, predicate: validatorPredicateTrue, predicateParameters: [], errorPlaceholder: errorPlaceholder, errorMessage: "")
        vc.add(validator: validator1)
        
        let validator2 = Validator(control: firstControl, predicate: { (param1, param2) -> Bool in
            return false
        }, predicateParameters: [], errorPlaceholder: errorPlaceholder, errorMessage: "V2 ERROR")
        vc.add(validator: validator2)
        
        
        // Third and forth are never executed
        let validator3 = Validator(control: firstControl, predicate: validatorPredicateTrue, predicateParameters: [], errorPlaceholder: errorPlaceholder, errorMessage: "")
        vc.add(validator: validator3)
        
        XCTAssertFalse(vc.validate(), "One of the validators return false but form is valid")
        XCTAssertNotNil(vc.firstFailedControl, "Failed control should not be empty because form has failed validation")
        XCTAssertEqual(firstControl.tag, vc.firstFailedControl?.tag)
    }
    
    
    
    
    func testCondition0() {
        let validator1 = Validator(control: UITextField(), predicate: validatorPredicateTrue, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        
        vc.add(validator: validator1, condition: { () -> Bool in
            return true
        })
            
        XCTAssert(vc.validate(), "Default validator behaviour")
            
        
        let validator2 = Validator(control: UITextField(), predicate: { (param1, param2) -> Bool in
            return false
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "V2 ERROR")
        vc.add(validator: validator2, condition: { () -> Bool in
            return true
        })
        XCTAssertFalse(vc.validate(), "Default validator behaviour should return false")
        
    }
    
    
    
    func testCondition1() {
        let validator3 = Validator(control: UITextField(), predicate: validatorPredicateTrue, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        
        vc.add(validator: validator3, condition: { () -> Bool in
            return false
        })
        
        XCTAssert(vc.validate(), "Validator should never be executed")
    }
    
    
    
    
    func testCondition2() {
        let validator4 = Validator(control: UITextField(), predicate: validatorPredicateFalse, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        
        vc.add(validator: validator4, condition: { () -> Bool in
            return false
        })
        
        XCTAssert(vc.validate(), "Validator should never be executed")
    }
    
    
    func testCondition3() {
        // chain validation
        let validator1 = Validator(control: UITextField(), predicate: validatorPredicateFalse, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        
        vc.add(validator: validator1, condition: { () -> Bool in
            return false
        })
        
        
        // chain validation
        let label = UILabel()
        let validator2 = Validator(control: UITextField(), predicate: { (param1, param2) -> Bool in
            return false
        }, predicateParameters: [], errorPlaceholder: label, errorMessage: "ERROR")
        
        vc.add(validator: validator2)
        
        XCTAssertFalse(vc.validate(), "Validation should fail")
        XCTAssertEqual(label.text, "ERROR")
    }
    
    
    
    func testCondition4() {
        // chain validation
        let label1 = UILabel()
        let validator1 = Validator(control: UITextField(), predicate: { (param1, param2) -> Bool in
            return false
        }, predicateParameters: [], errorPlaceholder: label1, errorMessage: "ERROR1")
        
        vc.add(validator: validator1, condition: { () -> Bool in
            return true
        })
        
        
        // chain validation
        let label2 = UILabel()
        let validator2 = Validator(control: UITextField(), predicate: { (param1, param2) -> Bool in
            return false
        }, predicateParameters: [], errorPlaceholder: label2, errorMessage: "ERROR2")
        
        vc.add(validator: validator2)
        
        XCTAssertFalse(vc.validate(), "Validation should fail")
        XCTAssertEqual(label1.text, "ERROR1")
        XCTAssertEqual(label2.text, "ERROR2")
    }
    
    
    
}
