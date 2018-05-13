//
//  ValidatorController.swift
//  EGFormValidator
//
//  Created by Roberto Casula on 11/05/18.
//  Copyright © 2018 Evgeny Gushchin. All rights reserved.
//

import UIKit

public class WeakRef<T> where T: AnyObject {
    
    private(set) weak var value: T?
    
    init(value: T?) {
        self.value = value
    }
}

/// Declares validation condition
public typealias ValidatorCondition = () -> Bool

public protocol ValidatorController: class {
    var validators: [WeakRef<Validator>] { get set }
    var validatorConditions: [ValidatorCondition] { get set }
    
    /// Read-only property that stores the first failed in case if you need to scroll up your view and to show the invalid control
    var firstFailedControl: UIView? { get set }
    
    func add(validator: Validator)
    func add(validator: Validator, condition: @escaping ValidatorCondition)
    
    func validate() -> Bool
}
