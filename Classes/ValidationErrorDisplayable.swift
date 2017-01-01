//
//  ValidationErrorDisplayable.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 09/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import Foundation

/**
 If an object conforms to this protocol, it can be being able to display an a validatar's error.
 
 `UILabel` adopts this protocol.
 */
public protocol ValidationErrorDisplayable {
    
    /**
     A required delegate method that is in charge to properly display an error message
     
     - Parameter errorMessage: an error message to be shown when a validator fails
     */
    func setErrorMessage(errorMessage: String?)
}
