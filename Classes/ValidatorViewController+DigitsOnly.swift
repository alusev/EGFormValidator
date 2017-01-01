//
//  ValidatorViewController+DigitsOnly.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 19/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

/// The extension adds DigitsOnly validator
public extension ValidatorViewController {
    /**
     Validator's predicate: verifies if given value contains only digits
     
     - Parameter value: A value of the validated control
     - Parameter params: A list of other parameters to pass to predicate. In this case empty array is expected
     - Returns: `True` if the value contains only digits
     */
    fileprivate func DigitsValidator(value: Any?, params: [Any?]) -> Bool {
        let badCharacters = NSCharacterSet.decimalDigits.inverted
    
        if let numbersString = value as? String, numbersString.rangeOfCharacter(from: badCharacters) == nil {
            return true
        }
        return false
    }
    

    /**
     Adds digits-only validator
     
     - Parameter control: A control to be validated. The control must adopt `UIViewThatConformsValidatableProtocol`
     - Parameter errorPlaceholder: An object that will display an error message
     - Parameter errorMessage: A message that will be displayed in the errorPlaceholder object
     */
    public func addValidatorDigitsOnly<UIViewThatConformsValidatableProtocol: UIView>
                                            (toControl control: UIViewThatConformsValidatableProtocol?,
                                              errorPlaceholder: ValidationErrorDisplayable?,
                                                  errorMessage: String)
                            where UIViewThatConformsValidatableProtocol: Validatable {
            
            let aValidator = Validator(control: control,
                                       predicate: DigitsValidator,
                                       predicateParameters: [],
                                       errorPlaceholder: errorPlaceholder,
                                       errorMessage: errorMessage)
            self.add(validator: aValidator)
    }
}
