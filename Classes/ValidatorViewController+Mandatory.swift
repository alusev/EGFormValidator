//
//  ValidatorViewController+Mandatory.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

/// The extension adds Mandatory validator
public extension ValidatorViewController {
    
    /**
     Validator's predicate: verifies if given value is not empty
     - Parameter value: A value of the validated control
     - Parameter params: A list of other parameters to pass to predicate. In this case empty array is expected
     - Returns: `True` if the value is not empty
     */
    fileprivate func MandatoryValidator(value: Any?, params: [Any?]) -> Bool {
        // whatever type is it, if it is nil, always return FALSE
        if value == nil {
            return false
        }
        
        if value is String {
            let stringValue = value as! String
            return !stringValue.isEmpty
        }
    
        return true
    }
    
    
    
    /**
     Adds mandatory validator
     
     - Parameter control: A control to be validated. The control must adopt `UIViewThatConformsValidatableProtocol`
     - Parameter errorPlaceholder: An object that will display an error message
     - Parameter errorMessage: A message that will be displayed in the errorPlaceholder object
     */
    public func addValidatorMandatory<UIViewThatConformsValidatableProtocol: UIView>
                                            (toControl control: UIViewThatConformsValidatableProtocol?,
                                              errorPlaceholder: ValidationErrorDisplayable?,
                                                  errorMessage: String)
                            where UIViewThatConformsValidatableProtocol: Validatable {
            
        let aValidator = Validator(control: control,
                                   predicate: MandatoryValidator,
                                   predicateParameters: [],
                                   errorPlaceholder: errorPlaceholder,
                                   errorMessage: errorMessage)
        self.add(validator: aValidator)
    }
}
