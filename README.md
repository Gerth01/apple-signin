# Apple-signin
Project to demonstrate how to signin with apple

## Get Started

### Requirements

* Xcode 11
* iOs 13.0

### App id (Developer account)

First of all, you have to add this functionnality when you declare your application on the apple developer account.

![app id apple account](https://raw.githubusercontent.com/Gerth01/apple-signin/master/img/screenshot-app-id.png)


### Authentication framework

Add the "Authentication framework" to your project. And import it :

````swift
import AuthenticationServices
````

### Adding Capability

To enable the "Apple sign in" in your application, you have to add the 'Capability' in the "Signing & Capabilities" Section in the xcodeproj. This will create an entitlements file.

### Button view

Declare a button from the Apple Signin, add a target and add this button to your view : 

````swift
    let myAuthorButton = ASAuthorizationAppleIDButton()
    myAuthorButton.addTarget(self, action: #selector(onAuthorizationButtonClick), for: .touchUpInside)
    self.appleSigninView.addSubview(myAuthorButton)
````

### Delegate

Add the `ASAuthorizationControllerDelegate` to your class and overide the methods :

````swift
func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    // Compete Author
}

func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
````