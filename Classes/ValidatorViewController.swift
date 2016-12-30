//
//  ValidatorViewController.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit


open class ValidatorViewController: UIViewController {
    // MARK - VALIDATION
    private var validators = [Validator]()
    
    
    /**
     * Add a new validator to validation list
     */
    func add(validator: Validator) {
        validators.append(validator)
    }
    
    
    public private(set) var firstFailedControl: UIView?
    
    /**
     * Validates custom text fields
     */
    func validate() -> Bool {
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
