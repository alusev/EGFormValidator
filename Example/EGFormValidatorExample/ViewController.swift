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
    // Scrollview outlet
    @IBOutlet weak var scrollView: UIScrollView?
    
    
    // Inputs
    @IBOutlet weak var mandatoryTextField: UITextField!
    @IBOutlet weak var minLengthTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var digitsOnlyTextField: UITextField!
    @IBOutlet weak var equaltyTextField_1: UITextField!
    @IBOutlet weak var equaltyTextField_2: UITextField!
    
    // Error labels
    @IBOutlet weak var mandatoryErrorLabel: UILabel!
    @IBOutlet weak var minLengthErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var digitsOnlyErrorLabel: UILabel!
    @IBOutlet weak var equaltyErrorLabel: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        // Empty error labels (they have some text in the storyboard)
        self.mandatoryErrorLabel.text = ""
        self.minLengthErrorLabel.text = ""
        self.emailErrorLabel.text = ""
        self.digitsOnlyErrorLabel.text = ""
        self.equaltyErrorLabel.text = ""
        
        
        // add validators
        addValidators()
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    
    
    //
    // Add validators
    func addValidators() {
        
        // Add mandatory validator
        self.addMandatoryValidation(control: self.mandatoryTextField,
                           errorPlaceholder: self.mandatoryErrorLabel,
                               errorMessage: "This field is required")
        
        
        
        // Add minlength validator
        self.addValidation(control: self.minLengthTextField,
                         minLength: 8,
                  errorPlaceholder: self.minLengthErrorLabel,
                      errorMessage: "Enter at least %d characters")
        
        
        
        // Email validator
        self.addEmailValidation(control: self.emailTextField,
                       errorPlaceholder: self.emailErrorLabel,
                           errorMessage: "Email is invalid")
        
        
        // Add digits only validator
        self.addDigitsOnlyValidation(control: self.digitsOnlyTextField,
                            errorPlaceholder: self.digitsOnlyErrorLabel,
                                errorMessage: "Some of the characters are not digits")
        
        
        
        // Equalty validator
        self.addValidation(control: self.equaltyTextField_1,
                           equalTo: self.equaltyTextField_2,
                           errorPlaceholder: self.equaltyErrorLabel,
                           errorMessage: "The strings don't match")
    }
    
    
    
    
    
    //
    // Perform validation
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

