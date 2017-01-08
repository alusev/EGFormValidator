# EGFormValidator

[![Swift][swift-badge]][swift-url]
[![Build Status](https://travis-ci.org/alusev/EGFormValidator.svg?branch=master)](https://travis-ci.org/alusev/EGFormValidator)
[![codecov](https://codecov.io/gh/alusev/EGFormValidator/branch/master/graph/badge.svg)](https://codecov.io/gh/alusev/EGFormValidator)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/alusev/EGFormValidator/blob/master/LICENSE)
[swift-badge]: https://img.shields.io/badge/Swift-3.0-blue.svg
[swift-url]: https://swift.org

A simple form validation library written in Swift 3.0.

1. [Features](#features)
2. [Demo](#demo)
3. [Requirements](#requirements)
4. [Installation](#installation)
5. [Usage](#usage)
   - [Basic](#basic)
   - [Highlight valid and invalid inputs](#add-styles-highlight-valid-and-invalid-inputs)
   - [Custom validators](#custom-validators)
   - [Custom input fields](#custom-input-fields)
   - [Custom error placeholders](#custom-error-placeholders)
   - [Conditional validation](#conditional-validation)




## Features

* Built-in validators
  * Mandatory
  * Maxlength (currently only `UITextField` are supported) is a special one. Use storyboard to set it up.
  * Minlength
  * Email
  * DigitsOnly
  * EqualTo (an input value equals to another inputs value)
  * AlphaNumeric

* Custom validators

* Validates any `UITextField` or `UITextView` or you can create your own validatable input fields

* Add custom styles to highlight invalid input fields

* Conditional validation

## Demo
```
pod try EGFormValidator
```

## Requirements

- iOS 8.0+
- Xcode 8.2+
- Swift 3.0+

## Installation
The recommended approach to use _EGFormValidator_ in your project is using the [CocoaPods](http://cocoapods.org/) package manager, as it provides flexible dependency management and dead simple installation.

#### CocoaPods

Install CocoaPods if not already available:

```bash
$ [sudo] gem install cocoapods
$ pod setup
```
Go to the directory of your Xcode project, and Create and Edit your Podfile and add _EGFormValidator_ to your corresponding `TargetName`:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target 'TargetName' do
    pod 'EGFormValidator'
end
```

Install into your project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file):

``` bash
$ open MyProject.xcworkspace
```

You can now `import EGFormValidator` framework into your files.


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
        self.addValidatorMandatory(toControl: self.fullnameTextfield,
                            errorPlaceholder: self.fullnameErrorLabel,
                                errorMessage: "This field is required")
                                
        
        // Minlength
        self.addValidatorMinLength(toControl: self.fullnameTextfield,
                            errorPlaceholder: self.fullnameErrorLabel,
                                errorMessage: "Enter at least %d characters",
                                   minLength: 8)
        
     
        // Email
        self.addValidatorEmail(toControl: self.emailTextField,
                        errorPlaceholder: self.emailErrorLabel,
                            errorMessage: "Email is invalid")

        // Digits Only
        self.addValidatorDigitsOnly(toControl: self.postalCodeTextfield,
                             errorPlaceholder: self.postalCodeErrorLabel,
                                 errorMessage: "Postal code must contain only digits")
                                 
        
        // Equalty
        self.addValidatorEqualTo(toControl: self.passwordConfirmationTextField,
                          errorPlaceholder: self.passwordConfirmationErrorLabel,
                              errorMessage: "Passwords don't match",
                        compareWithControl: self.passwordTextField)

        // AlphaNumeric
        self.addValidatorAlphaNumeric(toControl: self.alphaNumericTextField,
                               errorPlaceholder: self.aphaNumericErrorLabel,
                                   errorMessage: "Only letters and digits are allowed")
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


### Conditional validation

You can define wheather you want to apply a specific validator or not. Simply add a condition to a validator.

For a custom validator:

```swift
self.add(validator: aValidator, condition: { () -> Bool {
   return false // return true if you want to apply this validator and false otherwise
})
```

For a core validator: 
```swift
// in this case it's digit-only validator, the same syntax is applied to the others
self.addValidatorDigitsOnly(toControl: self.myTextfield,
                             errorPlaceholder: self.myTextfieldErrorLabel,
                                 errorMessage: "Digits only please") { () -> Bool {
   return false // return true if you want to apply this validator and false otherwise
}
```

Let's say if you have two fields: a landline and a cellphone. And you want a user to fill in at least one of them.

```swift
self.addValidatorMandatory(toControl: self.cellphoneTextfield,
                   errorPlaceholder: self.cellphoneErrorLabel,
                       errorMessage: "Please enter your home phone number or your cellphone") { [unowned self] () -> Bool in
       if let landline = self.landlineTextfield.getValue() as? String, landline.characters.count > 1 {
           return false
       }
       return true
}

self.addValidatorMandatory(toControl: self.landlineTextfield,
                   errorPlaceholder: self.landlineErrorLabel,
                       errorMessage: "Please enter your home phone number or your cellphone") { [unowned self] () -> Bool in
       if let cellphone = self.cellphoneTextfield.getValue() as? String, cellphone.characters.count > 1 {
           return false
       }

       return true
}
```
