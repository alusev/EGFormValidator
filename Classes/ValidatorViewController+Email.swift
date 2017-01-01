//
//  ValidatorViewController+Email.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

public extension ValidatorViewController {
    /**
     Validator's predicate: verifies if given value is a valid email address
     
     - Parameter value: A value of the validated control
     - Parameter params: A list of other parameters to pass to predicate. In this case empty array is expected
     */
    fileprivate func EmailValidator(value: Any?, params: [Any?]) -> Bool {
        if let email = value as? String, (email.isValidEmail() || email == "") {
            return true
        }
        return false
    }
    
    
    
    
    /**
     Adds email validator
     
     - Parameter control: A control to be validated. The control must adopt `UIViewThatConformsValidatableProtocol`
     - Parameter errorPlaceholder: An object that will display an error message
     - Parameter errorMessage: A message that will be displayed in the errorPlaceholder object
     */
    public func addValidatorEmail<UIViewThatConformsValidatableProtocol: UIView>
                                            (toControl control: UIViewThatConformsValidatableProtocol?,
                                       errorPlaceholder: ValidationErrorDisplayable?,
                                           errorMessage: String)
                            where UIViewThatConformsValidatableProtocol: Validatable {
        
        let aValidator = Validator(control: control,
                                   predicate: EmailValidator,
                                   predicateParameters: [],
                                   errorPlaceholder: errorPlaceholder,
                                   errorMessage: errorMessage)
        self.add(validator: aValidator)
    }
}
