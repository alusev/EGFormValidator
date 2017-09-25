//
//  UITextField+maxLength.swift
//  EGFormValidator
//
//  Created by Evgeny Gushchin on 19/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit

/// The variable holds an array of maxlength values of all `UITextFields`
private var maxLengths = [UITextField: Int]()

/// The extension adds MaxLength validator
extension UITextField {
    
    /// Defines a maximum characters number allow for the textfield 
    @IBInspectable public var maxLength: Int {
        get {
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            addTarget(
                self,
                action: #selector(limitLength),
                for: UIControlEvents.editingChanged
            )
        }
    }
    
    /**
     The method to be called on `UIControlEvents.editingChanged` event
     - Parameter textField: A textfield beeing edited
     */
    @objc func limitLength(textField: UITextField) {
        guard let prospectiveText = textField.text, prospectiveText.characters.count > maxLength else {
            return
        }
        
        let selection = selectedTextRange
        text = prospectiveText.substring(with:
            Range<String.Index>(prospectiveText.startIndex ..< prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength))
        )
        selectedTextRange = selection
    }
    
}

