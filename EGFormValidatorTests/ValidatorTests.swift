//
//  ValidatorTests.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 02/01/17.
//  Copyright © 2017 Evgeny Gushchin. All rights reserved.
//

import XCTest
@testable import EGFormValidator

class ValidatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPredicate() {
        let validator1 = Validator(control: UITextField(), predicate: { (a, b) -> Bool in
            return true
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        XCTAssert(validator1.validate(), "Validator must return true")
        
        let validator2 = Validator(control: UITextField(), predicate: { (a, b) -> Bool in
            return false
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        XCTAssertFalse(validator2.validate(), "Validator must return false")
    
        let textField = UITextField()
        textField.text = "Some value"
        let validator3 = Validator(control: textField, predicate: { (a, b) -> Bool in
            let stringValue = a as? String
            XCTAssertEqual(stringValue, textField.text, "The first predicate's parameter is not beeing passed")
            return true
        }, predicateParameters: [], errorPlaceholder: nil, errorMessage: "")
        let _ = validator3.validate()
        
        let predicateParams = ["a", "1", "x"]
        let validator4 = Validator(control: UITextField(), predicate: { (a, b) -> Bool in
            let params = b as! [String]
            XCTAssertEqual(params, predicateParams, "The second predicate's parameter is not beeing passed")
            return true
        }, predicateParameters: predicateParams, errorPlaceholder: nil, errorMessage: "")
        let _ = validator4.validate()
    }
    
    
    
}
