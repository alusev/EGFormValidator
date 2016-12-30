//
//  Validator.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import Foundation
import UIKit

// Declares custom validation method
typealias ValidatorPredicate = (Any?, [Any?]) -> Bool


public struct Validator {
    // a control to be validated
    var control: Validatable?
    
    // a method that validates the control
    var predicate: ValidatorPredicate
    
    // a list of other parameters to pass to predicate
    var predicateParameters: [Any?]
    
    // a placeholder that will display error
    var errorPlaceholder: ValidationErrorDisplayable?
    
    // an error message when the control fails validation
    var errorMessage: String

    
    
    /**
     * Perform validation of the control
     */
    public func validate() -> Bool {
        return predicate(control?.getValue(), predicateParameters)
    }
}
