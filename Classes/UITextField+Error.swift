//
//  UITextField+Error.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

/// The extension that makes all `UITextField` be able to be validated
extension UITextField: Validatable {
    
    /**
     MARK: - Validatable Protocol Implementation
     - Returns: A control's value
     */
    public func getValue() -> Any? {
        return self.text
    }
}


