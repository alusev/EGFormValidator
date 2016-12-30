//
//  ValidatorViewController+Minlength.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

extension ValidatorViewController {
    
    
    private func MinlengthValidator(value: Any?, params: [Any?]) -> Bool {
        let minLength = params[0] as! Int
        
        if let stringValue = value as? String, stringValue.characters.count >= minLength {
            return true
        }
        
        return false
    }
    
    
    
    /**
     * Validator method
     */
    func addValidation<UIViewThatConformsValidatableProtocol: UIView>
                                                 (control: UIViewThatConformsValidatableProtocol?,
                                                minLength: Int,
                                         errorPlaceholder: ValidationErrorDisplayable?,
                                         errorMessage: String = "El campo tiene que tener mínimo %d carácteres")
                        where UIViewThatConformsValidatableProtocol: Validatable {
            
            let aValidator = Validator(control: control,
                                       predicate: MinlengthValidator,
                                       predicateParameters: [minLength],
                                       errorPlaceholder: errorPlaceholder,
                                       errorMessage: String(format: errorMessage, minLength))
            self.add(validator: aValidator)
    }
    

    
    
}
