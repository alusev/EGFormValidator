//
//  ValidatorViewController+Equal.swift
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
    fileprivate func EqualtyValidator(value1: Any?, params: [Any?]) -> Bool {
        guard
            let control = params[0] as? Validatable else {
            return false
        }
        
        let value2 = control.getValue()
        
    
        if value1 == nil && value2 == nil {
            return true
        }
        
        if (value1 == nil && value2 != nil) || (value1 != nil && value2 == nil) {
            return false
        }
        
        if let equal = self.isEqual(type: String.self, a: value1!, b: value2!) {
            return equal
        }
        
        if let equal = self.isEqual(type: Character.self, a: value1!, b: value2!) {
            return equal
        }
        
        if let equal = self.isEqual(type: Int.self, a: value1!, b: value2!) {
            return equal
        }
        
        if let equal = self.isEqual(type: Double.self, a: value1!, b: value2!) {
            return equal
        }
        
        if let equal = self.isEqual(type: Float.self, a: value1!, b: value2!) {
            return equal
        }
        
        return false
    }
    
    
    
    // Equalty helper
    fileprivate func isEqual<T: Equatable>(type: T.Type, a: Any, b: Any) -> Bool? {
        guard let a = a as? T, let b = b as? T else { return nil }
        
        return a == b
    }
    
    
    
    
    /**
     * Validator method
     */
    public func addValidation<UIViewThatConformsValidatableProtocol: UIView>
                                        (control control1: UIViewThatConformsValidatableProtocol?,
                                equalTo control2: UIViewThatConformsValidatableProtocol?,
                                errorPlaceholder: ValidationErrorDisplayable?,
                                    errorMessage: String = "Los campos no coinciden")
                        where UIViewThatConformsValidatableProtocol: Validatable {
        
        let aValidator = Validator(control: control1,
                                   predicate: EqualtyValidator,
                                   predicateParameters: [control2],
                                   errorPlaceholder: errorPlaceholder,
                                   errorMessage: errorMessage)
        self.add(validator: aValidator)
    }

}
