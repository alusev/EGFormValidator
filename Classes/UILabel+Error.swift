//
//  UILabel+Error.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

/// The extension that makes all `UILabel` be able to display an error
extension UILabel: ValidationErrorDisplayable {
    
    /**
     MARK: - Validation Error Displayable protocol implementation
     
     - Parameter errorMessage: an error message to be shown when a validator fails
     */
    public func setErrorMessage(errorMessage: String?) {
        self.text = errorMessage
    }

}
