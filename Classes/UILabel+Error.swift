//
//  UILabel+Error.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

extension UILabel: ValidationErrorDisplayable {
    
    // MARK - Validation Error Displayable protocol implementation
    func setErrorMessage(errorMessage: String?) {
        self.text = errorMessage
    }

}
