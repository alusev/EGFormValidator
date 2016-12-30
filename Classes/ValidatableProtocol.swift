//
//  ValidatableProtocol.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

@objc protocol Validatable: class, NSObjectProtocol {
    // a control must return its value
    func getValue() -> Any?
    
    // a delegate method that gets called after validation
    @objc optional func setValidation(state: ValidatableControlState)
}



extension Validatable where Self: UIView {}




@objc enum ValidatableControlState: Int {
    // The control has not been validated yet
    case normal = 0
    
    // The control has been validated and it's valid
    case valid
    
    // The control has been validated and it's not valid
    case error
}
