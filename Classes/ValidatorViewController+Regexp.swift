//
//  ValidatorViewController+Regexp.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 08/01/17.
//  Copyright © 2017 Evgeny Gushchin. All rights reserved.
//

import UIKit

/// The extension adds Regexp validator
public extension ValidatorViewController {
    /**
     Validator's predicate: verifies if a given value matches the pattern
     
     - Parameter value: A value of the validated control
     - Parameter params: A list of other parameters to pass to predicate. In this case first element should be a String containing a patern
     - Returns: `True` if the value matches the pattern
     */
    func RegexpValidator(value: Any?, params: [Any?]) -> Bool {
        if let pattern = params.first as? String,
            let val = value as? String,
            let _ = val.range(of: pattern, options: .regularExpression, range: nil, locale: nil) {
            return true
        }
        return false
    }
    
    
    
    /**
     Adds regexp validator
     
     - Parameter control: A control to be validated. The control must adopt `UIViewThatConformsValidatableProtocol`
     - Parameter errorPlaceholder: An object that will display an error message
     - Parameter errorMessage: A message that will be displayed in the errorPlaceholder object
     - Parameter pattern: A regular expression pattern
     */
    public func addValidatorRegexp<UIViewThatConformsValidatableProtocol: UIView>
                                            (toControl control: UIViewThatConformsValidatableProtocol?,
                                              errorPlaceholder: ValidationErrorDisplayable?,
                                                  errorMessage: String,
                                                       pattern: String)
        where UIViewThatConformsValidatableProtocol: Validatable {
            
            self.addValidatorRegexp(toControl: control,
                                    errorPlaceholder: errorPlaceholder,
                                    errorMessage: errorMessage,
                                    pattern: pattern,
                                    condition: { return true })
    }
    
    
    
    
    /**
     Adds alphanumeric validator with condition
     
     - Parameter control: A control to be validated. The control must adopt `UIViewThatConformsValidatableProtocol`
     - Parameter errorPlaceholder: An object that will display an error message
     - Parameter errorMessage: A message that will be displayed in the errorPlaceholder object
     - Parameter pattern: A regular expression pattern
     - Parameter condition: A condition when the validator must be executed
     */
    public func addValidatorRegexp<UIViewThatConformsValidatableProtocol: UIView>
                                                      (toControl control: UIViewThatConformsValidatableProtocol?,
                                                        errorPlaceholder: ValidationErrorDisplayable?,
                                                            errorMessage: String,
                                                                 pattern: String,
                                                               condition: @escaping ValidatorCondition)
        where UIViewThatConformsValidatableProtocol: Validatable {
            let aValidator = Validator(control: control,
                                       predicate: RegexpValidator,
                                       predicateParameters: [pattern],
                                       errorPlaceholder: errorPlaceholder,
                                       errorMessage: errorMessage)
            self.add(validator: aValidator, condition: condition)
    }
}


