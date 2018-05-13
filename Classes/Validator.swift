//
//  Validator.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

/// Declares custom validation method
public typealias ValidatorPredicate = (Any?, [Any?]) -> Bool

/// `Validator`
public class Validator {
    
    /// A control to be validated
    var control: Validatable?
    
    /// A method that validates the control
    var predicate: ValidatorPredicate
    
    /// A list of other parameters to pass to predicate
    var predicateParameters: [Any?]
    
    /// A placeholder that will display error
    var errorPlaceholder: ValidationErrorDisplayable?
    
    /// An error message to be shown if the control fails validation
    var errorMessage: String
    
    /// Creates `Validator` instance
    ///
    /// - Parameters:
    ///     - control: A control that will be validated
    ///     - predicate: A function / method that will validate the control
    ///     - predicateParameters: An array of extra parameters that will be passed to the `predicate` as a second parameter
    ///     - errorPlaceholder: An object that will display an error message
    ///     - errorMessage: A message that will be displayed in the `errorPlaceholder` object
    public init(control: Validatable?, predicate: @escaping ValidatorPredicate, predicateParameters: [Any?], errorPlaceholder: ValidationErrorDisplayable?, errorMessage: String) {
        self.control = control
        self.predicate = predicate
        self.predicateParameters = predicateParameters
        self.errorPlaceholder = errorPlaceholder
        self.errorMessage = errorMessage
    }
    
    /**
     Performs validation of the control
     - Returns: `True` if the control passes validation
     */
    public func validate() -> Bool {
        return predicate(control?.getValue(), predicateParameters)
    }
    
}
