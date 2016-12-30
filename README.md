# EGFormValidator
A simple form validation library written in Swift 3.0.

[![Swift][swift-badge]][swift-url]
[![Build Status](https://travis-ci.org/alusev/FormValidator.svg?branch=master)](https://travis-ci.org/alusev/FormValidator)
[![codecov](https://codecov.io/gh/alusev/FormValidator/branch/master/graph/badge.svg)](https://codecov.io/gh/alusev/FormValidator)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/alusev/FormValidator/blob/master/LICENSE)


[swift-badge]: https://img.shields.io/badge/Swift-3.0-blue.svg
[swift-url]: https://swift.org

## Features

* Built-in validators
  * Mandatory
  * Maxlength (currently only `UITextField` are supported) is a special one. Use storyboard to set it up.
  * Minlength
  * Email
  * Digit-only
  * Equalty (an input value equals to another inputs value)
  
* Custom validators

* Validates any `UITextField` or `UITextView` or you can create your own validatable input fields

* Add custom styles to highlight invalid input fields


## Installation
Pods are commming soon


## Usage


### Basic
 _1. Extend `ValidatorViewController`_
 ```swift
class MyViewController: ValidatorViewController {
}
```

 _2. Place your validators in viewDidLoad in the order that they has to be executed._
```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // Place your validation code here   
        //
        // Mandatory validation
        self.addMandatoryValidation(control: self.fullnameTextfield, 
                           errorPlaceholder: self.fullnameErrorLabel,
                               errorMessage: "The field is required")
        
        // Minlength
        self.addValidation(control: self.fullnameTextfield, 
                         minLength: 5, 
                  errorPlaceholder: self.fullnameErrorLabel, 
                      errorMessage: "Please enter at least %d characters")
        
     
        // Email
        self.addEmailValidation(control: self.emailTextfield,
                       errorPlaceholder: self.emailErrorLabel,
                           errorMessage: "Email is invalid.")

        // Digits only
        self.addDigitsOnlyValidation(control: self.postalCodeTextfield, 
                            errorPlaceholder: self.postalCodeErrorLabel,
                                errorMessage: "Postal code must contain only digits")
        
        // Equalty
        self.addValidation(control: self.passwordConfirmationTextField,
                           equalTo: self.passwordTextField,
                           errorPlaceholder: self.passwordConfirmationErrorLabel,
                           errorMessage: "Passwords don't match")

    }
```
 _3. Execute `self.validate()` to validate your form_
```swift
if self.validate() {
  // form is valid
}
```



### Add styles: highlight valid and invalid inputs
Just implement `setValidation` optional method of `Validatable` protocol . For example:
```swift
import UIKit

class SuperTextField: UITextField, Validatable {
   // textfield initializatin 
   override init(frame: CGRect) {
        super.init(frame: frame)    
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }


    func xibSetup() { 
        layer.cornerRadius = 6
        layer.borderWidth = 2
        
        setNormalBorderColor()
    }



    func setNormalBorderColor() {
        layer.borderColor = UIColor(red: 244.0/255.0, green: 177.0/255.0, blue: 61.0/255.0, alpha: 1.0).cgColor
        textColor = UIColor(red: 86.0/255.0, green: 86.0/255.0, blue: 86.0/255.0, alpha: 1.0)
        backgroundColor = .white
    }
    

    //
    // MARK: - Validatable protocol implementation 
    func setValidation(state: ValidatableControlState) {
        if state == .error {
            layer.borderColor = UIColor(red: 230.0/255.0, green: 47.0/255.0, blue: 44.0/255.0, alpha: 1.0).cgColor
            textColor = .white
            backgroundColor = UIColor(red: 239.0/255.0, green: 158.0/255.0, blue: 158.0/255.0, alpha: 1.0)
        } else {
            setNormalBorderColor()
        }
    }
}
```



### Custom validators
Create a validator:
```swift
        let myNewShinyValidator = Validator(control: control, // any class that conforms Validatable protocol: use UITextField, UITextView or create your own (for more, see 'Custom input fields' section)
                                          predicate: AlphaNumericValidatorFunction  // a function that complies (Any?, [Any?]) -> Bool
                                predicateParameters: [], // Pass as many extra parametes as you want
                                   errorPlaceholder: errorPlaceholderLabel, // anything that conforms ValidationErrorDisplayable protocol: use UILabel or create your own (for more, see 'Custom error placeholders' section)
                                   errorMessage: "This input is invalid") // Error message
```

Create a predicate:
```swift
       func AlphaNumericValidatorFunction(value: Any?, params: [Any?]) -> Bool {
           let badCharacters = NSCharacterSet.alphanumerics.inverted
         
           if let myString = value as? String, myString.rangeOfCharacter(from: badCharacters) == nil {
                return true
            }
            return false
       }
```


Use `self.add(validator: myNewShinyValidator)` to add your validator.



### Custom input fields
Just implement `Validatable` protocol's required `getValue` method. For example:
```swift
import UIKit

extension MyDropDown: Validatable {
    
    // MARK - Validatable Protocol Implementation
    func getValue() -> Any? {
        return self.text // it must return a value that will be validated
    }
    
}
```


### Custom error placeholders
Implement `ValidationErrorDisplayable` protocol's required `setErrorMessage` method. For example:

```swift
import UIKit

extension SomeCustomView: ValidationErrorDisplayable {
    
    // MARK - Validation Error Displayable protocol implementation
    func setErrorMessage(errorMessage: String?) {
        // do stuff to show an error message
        self.errorLabel.text = errorMessage
    }

}
```
