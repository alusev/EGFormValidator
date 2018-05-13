//
//  ValidatorController+EqualTo.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

/// The extension adds EqualTo validator
public extension ValidatorController {
    /**
     Validator's predicate: verifies if given value is equal to another control's value
     
     - Parameter value1: A value of the validated control
     - Parameter params: A list of other parameters to pass to predicate. In this case it's expected an array with one element that conforms to `UIViewThatConformsValidatableProtocol` protocol
     - Returns: `True` if the value is equal to another control's value
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
    
    
    
    /**
     Equalty helper: tells if **a** equals to **b**
     
     – Parameter type: An expected type of values **a** and **b**
     - Parameter a: A value to be compared with **b**
     - Parameter b: A value to be compared with **a**
     - Returns: `True` if the values are aqual
     */
    fileprivate func isEqual<T: Equatable>(type: T.Type, a: Any, b: Any) -> Bool? {
        guard let a = a as? T, let b = b as? T else { return nil }
        
        return a == b
    }
    
    
    
    
    /**
     Adds equalTo validator
     
     - Parameter control1: A control to be validated. The control must adopt `UIViewThatConformsValidatableProtocol`
     - Parameter errorPlaceholder: An object that will display an error message
     - Parameter errorMessage: A message that will be displayed in the errorPlaceholder object
     - Parameter control2: A control to be compared with. The control must adopt `UIViewThatConformsValidatableProtocol`
     */
    public func addValidatorEqualTo<UIViewThatConformsValidatableProtocol: UIView>
                                            (toControl control1: UIViewThatConformsValidatableProtocol?,
                                               errorPlaceholder: ValidationErrorDisplayable?,
                                                   errorMessage: String,
                                    compareWithControl control2: UIViewThatConformsValidatableProtocol?)
                            where UIViewThatConformsValidatableProtocol: Validatable {
        
        self.addValidatorEqualTo(toControl: control1,
                          errorPlaceholder: errorPlaceholder,
                              errorMessage: errorMessage,
                        compareWithControl: control2,
                                 condition: { return true })
    }

    
    
    /**
     Adds equalTo validator with condition
     
     - Parameter control1: A control to be validated. The control must adopt `UIViewThatConformsValidatableProtocol`
     - Parameter errorPlaceholder: An object that will display an error message
     - Parameter errorMessage: A message that will be displayed in the errorPlaceholder object
     - Parameter control2: A control to be compared with. The control must adopt `UIViewThatConformsValidatableProtocol`
     - Parameter condition: A condition when the validator must be executed
     */
    public func addValidatorEqualTo<UIViewThatConformsValidatableProtocol: UIView>
                                            (toControl control1: UIViewThatConformsValidatableProtocol?,
                                               errorPlaceholder: ValidationErrorDisplayable?,
                                                   errorMessage: String,
                                    compareWithControl control2: UIViewThatConformsValidatableProtocol?,
                                                      condition: @escaping ValidatorCondition)
        where UIViewThatConformsValidatableProtocol: Validatable {
            
            let aValidator = Validator(control: control1,
                                       predicate: EqualtyValidator,
                                       predicateParameters: [control2],
                                       errorPlaceholder: errorPlaceholder,
                                       errorMessage: errorMessage)
            self.add(validator: aValidator, condition: condition)
    }
    
    
}
