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
        self.addMandatoryValidation(control: self.mandatoryTextField, errorPlaceholder: self.mandatoryErrorLabel, errorMessage: "This field is required!")
    }
    
    
    
    
    
    //
    // Perform validation
    @IBAction func validateButtonTapped(_ sender: Any) {
        if self.validate() {
            
        } else {
            // scroll to the first invalid input field
            self.scrollView?.scrollRectToVisible(self.firstFailedControl!.frame, animated: true)
        }
    }
}

