//
//  CustomTextfield.swift
//  EGFormValidatorExample
//
//  Created by Evgeny Gushchin on 01/01/17.
//  Copyright © 2017 Evgeny Gushchin. All rights reserved.
//

import UIKit
import Foundation
import EGFormValidator

class CustomTextfield: UITextField, UITextFieldDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        xibSetup()
    }
    
    
    
    
    func xibSetup() {
        font = .systemFont(ofSize: 18)
        layer.cornerRadius = 6
        layer.borderWidth = 2
        
        
        setInitialStyles()
    }
    
    
    
    
    // Initial styles
    func setInitialStyles() {
        backgroundColor = isEnabled ? .white : UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        layer.borderColor = UIColor(red: 244.0/255.0, green: 177.0/255.0, blue: 61.0/255.0, alpha: 1.0).cgColor
        textColor = UIColor(red: 86.0/255.0, green: 86.0/255.0, blue: 86.0/255.0, alpha: 1.0)
    }
    
    
    // On-focus styles
    func setOnFocusStyles() {
        backgroundColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        layer.borderColor = UIColor(red: 0/255.0, green: 47.0/255.0, blue: 113.0/255.0, alpha: 1.0).cgColor
        textColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0)
    }
    
    
    // On-error styles
    func setErrorStyles() {
        backgroundColor = UIColor(red: 239.0/255.0, green: 158.0/255.0, blue: 158.0/255.0, alpha: 1.0)
        layer.borderColor = UIColor(red: 230.0/255.0, green: 47.0/255.0, blue: 44.0/255.0, alpha: 1.0).cgColor
        textColor = .white
    }
    
    
    
    //
    // Set styles for disabled textfield
    override var isEnabled: Bool {
        didSet {
            self.backgroundColor = isEnabled ? .white : UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        }
    }
    
    
    //
    // Highlight the textfield on focus
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        if result {
            self.setOnFocusStyles()
        }
        
        return result
    }
    
    
    //
    // Out of focus
    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        if result {
            self.setInitialStyles()
        }
        
        return result
    }
    
    
    

    
    




    
    //
    // MARK: - Validatable protocol implementation
    func setValidation(state: ValidatableControlState) {
        if state == .error {
            // colors of invalid textfield
            setErrorStyles()
        } else {
            setInitialStyles()
        }
    }

}
