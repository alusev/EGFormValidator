//
//  UITextField+Error.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

extension UITextField: Validatable {
    
    // MARK - Validatable Protocol Implementation
    public func getValue() -> Any? {
        return self.text
    }
    
}


