//
//  ValidatorViewController.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

/// Adds to `UIViewController` validation functionality
open class ValidatorViewController: UIViewController {
    // MARK - VALIDATION
    private var validators = [Validator]()
    
    
    
    /**
     Adds a new validator to a validation list
     
     - Parameter validator: A validator to be added to the validation list
     
     The order of added validators matters. The first added validators will be executed first.
     If a validator of a control fails, the other validators of the control will not be executed.
     It recommended to add validatots consequently respecting the order of a fields in the form.
     */
    public func add(validator: Validator) {
        validators.append(validator)
    }
    
    
    
    /// Read-only property that stores the first failed in case if you need to scroll up your view and to show the invalid control
    public private(set) var firstFailedControl: UIView?
    
    
    
    /**
     Execute all predicates of all validators i.e. performs validation of a form
     
     - Returns: Tells if _all validators_ are valid or not.
     */
    public func validate() -> Bool {
        var formIsValid = true
        
        // a set of  invalidated controls
        
        var inValidatedControls = Set<UIView>()
        self.firstFailedControl = nil
        
        for validator in validators {
            var isControlValid = false
            
            // all controls should be UIViews so there shouldn't be any problem
            if let control = validator.control as? UIView {
                
                // validate it again only if it passed previous validation
                if !inValidatedControls.contains(control) {
                    // the control is not validated yet
                    // or it has been already validated and it passed all its previus validations
                    
                    // get validation result
                    isControlValid = validator.validate()
                    
                    if isControlValid {
                        // control is valid
                        validator.control?.setValidation?(state: .valid)
                        validator.errorPlaceholder?.setErrorMessage(errorMessage: nil)
                    } else {
                        // control is not valid
                        validator.control?.setValidation?(state: .error)
                        validator.errorPlaceholder?.setErrorMessage(errorMessage: validator.errorMessage)
                        
                        // add the control to inValidatedControls set
                        inValidatedControls.insert(control)
                        
                        if self.firstFailedControl == nil {
                            self.firstFailedControl = control
                        }
                    }
                }
            }
            
            // add the current control validation results to output
            formIsValid = formIsValid && isControlValid
        }
        return formIsValid
    }
}
