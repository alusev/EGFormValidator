//
//  ValidatorController+Minlength.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

/// The extension adds Minlength validator
extension ValidatorController {
    
    /**
     Validator's predicate: verifies if given value has at least `value` characters
     
     - Parameter value: A value of the validated control
     - Parameter params: A list of other parameters to pass to predicate. In this case empty array is expected
     - Returns: `True` if the value has at least `value` characters
     */
    private func MinlengthValidator(value: Any?, params: [Any?]) -> Bool {
        let minLength = params[0] as! Int
        
        if let stringValue = value as? String, (stringValue.count == 0 || stringValue.count >= minLength) {
            return true
        }
        
        return false
    }
    
    
    
    /**
     Adds minlength validator
     
     - Parameter control: A control to be validated. The control must adopt `UIViewThatConformsValidatableProtocol`
     - Parameter errorPlaceholder: An object that will display an error message
     - Parameter errorMessage: A message that will be displayed in the errorPlaceholder object
     - Parameter minLength: A minimum number of characters required for control
     */
    public func addValidatorMinLength<UIViewThatConformsValidatableProtocol: UIView>
                                            (toControl control: UIViewThatConformsValidatableProtocol?,
                                              errorPlaceholder: ValidationErrorDisplayable?,
                                                  errorMessage: String,
                                                     minLength: Int)
                            where UIViewThatConformsValidatableProtocol: Validatable {
            
            self.addValidatorMinLength(toControl: control,
                                errorPlaceholder: errorPlaceholder,
                                    errorMessage: errorMessage,
                                       minLength: minLength,
                                       condition: { return true })
    }
    

    
    
    /**
     Adds minlength validator with condition
     
     - Parameter control: A control to be validated. The control must adopt `UIViewThatConformsValidatableProtocol`
     - Parameter errorPlaceholder: An object that will display an error message
     - Parameter errorMessage: A message that will be displayed in the errorPlaceholder object
     - Parameter minLength: A minimum number of characters required for control
     - Parameter condition: A condition when the validator must be executed
     */
    public func addValidatorMinLength<UIViewThatConformsValidatableProtocol: UIView>
                                            (toControl control: UIViewThatConformsValidatableProtocol?,
                                              errorPlaceholder: ValidationErrorDisplayable?,
                                                  errorMessage: String,
                                                     minLength: Int,
                                                     condition: @escaping ValidatorCondition)
        where UIViewThatConformsValidatableProtocol: Validatable {
            
            let aValidator = Validator(control: control,
                                       predicate: MinlengthValidator,
                                       predicateParameters: [minLength],
                                       errorPlaceholder: errorPlaceholder,
                                       errorMessage: String(format: errorMessage, minLength))
            self.add(validator: aValidator, condition: condition)
    }
}
