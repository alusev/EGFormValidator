//
//  ViewController.swift
//  EGFormValidatorExample
//
//  Created by Evgeny Gushchin on 30/12/16.
//  Copyright © 2016 Evgeny Gushchin. All rights reserved.
//

import UIKit
import EGFormValidator

class ViewController: ValidatorViewController {
    /// Scrollview outlet
    @IBOutlet weak var scrollView: UIScrollView?
    
    
    /// Inputs
    @IBOutlet weak var mandatoryTextField: UITextField!
    @IBOutlet weak var minLengthTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var digitsOnlyTextField: UITextField!
    @IBOutlet weak var equaltyTextField_1: UITextField!
    @IBOutlet weak var equaltyTextField_2: UITextField!
    @IBOutlet weak var alphaNumericTextField: UITextField!
    @IBOutlet weak var regexpTextField: UITextField!
    @IBOutlet weak var conditionalTextField_1: UITextField!
    @IBOutlet weak var conditionalTextField_2: UITextField!
    @IBOutlet weak var customStyledTextField: UITextField!
    
    
    
    /// Error labels
    @IBOutlet weak var mandatoryErrorLabel: UILabel!
    @IBOutlet weak var minLengthErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var digitsOnlyErrorLabel: UILabel!
    @IBOutlet weak var equaltyErrorLabel: UILabel!
    @IBOutlet weak var regexpErrorLabel: UILabel!
    @IBOutlet weak var aphaNumericErrorLabel: UILabel!
    @IBOutlet weak var conditionalErrorLabel_1: UILabel!
    @IBOutlet weak var conditionalErrorLabel_2: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        // Empty error labels (they have some text in the storyboard)
        self.mandatoryErrorLabel.text = ""
        self.minLengthErrorLabel.text = ""
        self.emailErrorLabel.text = ""
        self.digitsOnlyErrorLabel.text = ""
        self.equaltyErrorLabel.text = ""
        self.aphaNumericErrorLabel.text = ""
        self.regexpErrorLabel.text = ""
        self.conditionalErrorLabel_1.text = ""
        self.conditionalErrorLabel_2.text = ""
        
        
        // add validators
        addValidators()
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    
    
    //
    /// Add validators
    func addValidators() {
        
        // Mandatory validator
        self.addValidatorMandatory(toControl: self.mandatoryTextField,
                            errorPlaceholder: self.mandatoryErrorLabel,
                                errorMessage: "This field is required")
        
        
        // Minlength validator
        self.addValidatorMinLength(toControl: self.minLengthTextField,
                            errorPlaceholder: self.minLengthErrorLabel,
                                errorMessage: "Enter at least %d characters",
                                   minLength: 8)
        
        // Email validator
        self.addValidatorEmail(toControl: self.emailTextField,
                        errorPlaceholder: self.emailErrorLabel,
                            errorMessage: "Email is invalid")
        
        
        // Digits only validator
        self.addValidatorDigitsOnly(toControl: self.digitsOnlyTextField,
                             errorPlaceholder: self.digitsOnlyErrorLabel,
                                 errorMessage: "Some of the characters are not digits")
        
        
        // Equalty validator
        self.addValidatorEqualTo(toControl: self.equaltyTextField_1,
                          errorPlaceholder: self.equaltyErrorLabel,
                              errorMessage: "The strings don't match",
                        compareWithControl: self.equaltyTextField_2)
        
        
        // Alphanumeric validator
        self.addValidatorAlphaNumeric(toControl: self.alphaNumericTextField,
                               errorPlaceholder: self.aphaNumericErrorLabel,
                                   errorMessage: "Only letters and digits are allowed")
        
        
        // Regular Expression validator
        self.addValidatorRegexp(toControl: self.regexpTextField,
                         errorPlaceholder: self.regexpErrorLabel,
                             errorMessage: "String doesn't match regular expression: ^\\d\\s\\d+$",
                                  pattern: "^\\d\\s\\d+$")
        
        
        
        //
        // Conditional validators
        // This mandatory rule will be fired only if the other textfield is empty
        self.addValidatorMandatory(toControl: self.conditionalTextField_1,
                            errorPlaceholder: self.conditionalErrorLabel_1,
                                errorMessage: "Enter a value in the field above or below") { () -> Bool in
            // Check if there's any value in the other textfield
            if let condTF2 = self.conditionalTextField_2.getValue() as? String, condTF2.characters.count > 0 {
                return false
            }
            return true
        }
        
        
        // This mandatory rule will be fired only if the other textfield is empty
        self.addValidatorMandatory(toControl: self.conditionalTextField_2,
                            errorPlaceholder: self.conditionalErrorLabel_2,
                                errorMessage: "Enter a value in one of the fields above") { () -> Bool in
            // Check if there's any value in the other textfield
            if let condTF1 = self.conditionalTextField_1.getValue() as? String, condTF1.characters.count > 0 {
                return false
            }
            return true
        }
        
        // This rule validates the first textfield and it will be fired if the first textfield is not empty.
        self.addValidatorDigitsOnly(toControl: self.conditionalTextField_1,
                             errorPlaceholder: self.conditionalErrorLabel_1,
                                 errorMessage: "Only digits are allowed in the first textfield")
        
        // This rule validates the second textfield and it will be fired if the second textfield is not empty.
        self.addValidatorRegexp(toControl: self.conditionalTextField_2,
                         errorPlaceholder: self.conditionalErrorLabel_2,
                             errorMessage: "Only latin letters are allowed in the second textfield",
                                  pattern: "^[A-Za-z]*$")
        
        
        
        
        // Custom styled textfield
        // In this case it doesn't matter which validator we use.
        self.addValidatorMandatory(toControl: self.customStyledTextField,
                            errorPlaceholder: nil, // This time we are not going to show an error message
                                errorMessage: "")
    }
    
    
    
    
    
    //
    /// Performs validation
    @IBAction func validateButtonTapped(_ sender: Any) {
        
        if self.validate() {
            // show success alert
            let alert = UIAlertController(title: "Congratulations!",
                                          message: "All fields are valid",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        } else {
            // scroll to the first invalid input field
            self.scrollView?.scrollRectToVisible(self.firstFailedControl!.frame, animated: true)
        }
    }
}

