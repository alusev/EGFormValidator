//
//  ValidatorViewController+Mandatory.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

public extension ValidatorViewController {
    /**
     * Verifies if given value is not empty
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
