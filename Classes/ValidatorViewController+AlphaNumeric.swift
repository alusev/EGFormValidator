//
//  ValidatorViewController+AlphaNumeric.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 31/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

public extension ValidatorViewController {
    /**
     Validator's predicate: verifies if given value contains only digits or letters
     
     - Parameter value: A value of the validated control
     - Parameter params: A list of other parameters to pass to predicate. In this case empty array is expected
     */
    func AlphaNumericValidator(value: Any?, params: [Any?]) -> Bool {
        let badCharacters = NSCharacterSet.alphanumerics.inverted
        
        if let myString = value as? String, myString.rangeOfCharacter(from: badCharacters) == nil {
            return true
        }
        return false
    }
    
    
    
    /**
     Adds alphanumeric validator
     
     - Parameter control: A control to be validated. The control must adopt `UIViewThatConformsValidatableProtocol`
     - Parameter errorPlaceholder: An object that will display an error message
     - Parameter errorMessage: A message that will be displayed in the errorPlaceholder object
     */
    public func addValidatorAlphaNumeric<UIViewThatConformsValidatableProtocol: UIView>
                                            (toControl control: UIViewThatConformsValidatableProtocol?,
                                              errorPlaceholder: ValidationErrorDisplayable?,
                                                  errorMessage: String)
        where UIViewThatConformsValidatableProtocol: Validatable {
            
            let aValidator = Validator(control: control,
                                       predicate: AlphaNumericValidator,
                                       predicateParameters: [],
                                       errorPlaceholder: errorPlaceholder,
                                       errorMessage: errorMessage)
            self.add(validator: aValidator)
    }
}
