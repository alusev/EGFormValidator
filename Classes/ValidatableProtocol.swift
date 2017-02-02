//
//  ValidatableProtocol.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

/**
 If an object conforms to this protocol, it can be considered as validatable object. Such objects must also be `UIView`
 `UITextField` and `UITextView` adopt this protocol.
 */
@objc public protocol Validatable: class, NSObjectProtocol {
    /**
     A required delegate method that returns control's value
     - Returns: A control's value
     */
    func getValue() -> Any?

    /**
     An _optional_ delegate method that gets called after validation to set its validation state
     - Parameter state: a state of the control after validation.
     */
    @objc optional func setValidation(state: ValidatableControlState)
}


/// Only `UIView`s can adopt `Validatable` protocol
extension Validatable where Self: UIView {}



/**
 A list of states of an object that conforms `Validatable` protocol:
 
 **normal**
 
 The control has not been validated yet. This is default state
 
 **valid**
 
 The control has been validated and it's valid
 
 **error**
 
 The control has been validated and it's not valid
 */
@objc public enum ValidatableControlState: Int {
    /// The control has not been validated yet
    case normal = 0

    /// The control has been validated and it's valid
    case valid

    /// The control has been validated and it's not valid
    case error
}
