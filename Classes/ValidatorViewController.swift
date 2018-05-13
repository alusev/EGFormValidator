//
//  ValidatorViewController.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit


/// Adds to subclasses of `UIViewController` validation functionality
public extension ValidatorController where Self: UIViewController {
    
    /**
     Adds a new unconditional validator to a validation list
     - Parameter validator: A validator to be added to the validation list
     The order of added validators matters. The first added validators will be executed first.
     If a validator of a control fails, the other validators of the control will not be executed.
     It recommended to add validatots consequently respecting the order of a fields in the form.
     */
    public func add(validator: Validator) {
        self.add(validator: validator) { () -> Bool in
            return true
        }
    }
    
    /**
     Adds a new conditional validator to a validation list
     - Parameter validator: A validator to be added to the validation list
     - Parameter condition: A condition when the validator must be executed
     The order of added validators matters. The first added validators will be executed first.
     If a validator of a control fails, the other validators of the control will not be executed.
     It recommended to add validatots consequently respecting the order of a fields in the form.
     If condition returns `false` the validator will mark the field as valid.
     */
    public func add(validator: Validator, condition: @escaping ValidatorCondition) {
        let weakValidator = WeakRef(value: validator)
        validators.append(weakValidator)
        validatorConditions.append(condition)
    }
    
    /**
     Execute all predicates of all validators i.e. performs validation of a form
     - Returns: Tells if _all validators_ are valid or not.
     */
    public func validate() -> Bool {
        var formIsValid = true
        
        // a set of  invalidated controls
        var inValidatedControls = Set<UIView>()
        self.firstFailedControl = nil
        
        for (index, validator) in validators.enumerated() {
            var isControlValid = false
            
            // all controls should be UIViews so there shouldn't be any problem
            if let validator = validator.value,
                let control = validator.control as? UIView {
                
                // validate it again only if it passed previous validation
                if !inValidatedControls.contains(control) {
                    // the control is not validated yet
                    // or it has been already validated and it passed all its previus validations
                    
                    // check conditions
                    if validatorConditions[index]() {
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
                    } else {
                        // validator was executed
                        // control is valid
                        isControlValid = true
                        validator.control?.setValidation?(state: .valid)
                        validator.errorPlaceholder?.setErrorMessage(errorMessage: nil)
                    }
                }
            }
            
            // add the current control validation results to output
            formIsValid = formIsValid && isControlValid
        }
        return formIsValid
    }
}

open class ValidatorViewController: UIViewController, ValidatorController {
    public var firstFailedControl: UIView?
    
    public var validators: [WeakRef<Validator>] = [WeakRef<Validator>]()
    public var validatorConditions = [ValidatorCondition]()
}

open class ValidatorTableViewController: UITableViewController, ValidatorController {
    public var firstFailedControl: UIView?
    
    public var validators: [WeakRef<Validator>] = [WeakRef<Validator>]()
    public var validatorConditions = [ValidatorCondition]()
}

open class ValidatorTabBarController: UITabBarController, ValidatorController {
    public var firstFailedControl: UIView?
    
    public var validators: [WeakRef<Validator>] = [WeakRef<Validator>]()
    public var validatorConditions = [ValidatorCondition]()
}
