//
//  ValidatorViewController+Digits.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 19/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

extension ValidatorViewController {
    /**
     * Digit Validator
     */
    fileprivate func DigitsValidator(value: Any?, params: [Any?]) -> Bool {
        let badCharacters = NSCharacterSet.decimalDigits.inverted
    
        if let numbersString = value as? String, numbersString.rangeOfCharacter(from: badCharacters) == nil {
            return true
        }
        return false
    }
    

    func addDigitsOnlyValidation<UIViewThatConformsValidatableProtocol: UIView>
                    (control: UIViewThatConformsValidatableProtocol?,
                     errorPlaceholder: ValidationErrorDisplayable?,
                     errorMessage: String = "Únicamente dígitos")
                    where UIViewThatConformsValidatableProtocol: Validatable {
            
            let aValidator = Validator(control: control,
                                       predicate: DigitsValidator,
                                       predicateParameters: [],
                                       errorPlaceholder: errorPlaceholder,
                                       errorMessage: errorMessage)
            self.add(validator: aValidator)
    }
}
