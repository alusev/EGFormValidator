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
     * AlphaNumeric Validator
     */
    func AlphaNumericValidator(value: Any?, params: [Any?]) -> Bool {
        let badCharacters = NSCharacterSet.alphanumerics.inverted
        
        if let myString = value as? String, myString.rangeOfCharacter(from: badCharacters) == nil {
            return true
        }
        return false
    }
    
    
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
