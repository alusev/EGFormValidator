//
//  ValidationErrorDisplayable.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import Foundation

protocol ValidationErrorDisplayable {
    
    // a control must be able to show error
    func setErrorMessage(errorMessage: String?)
}
