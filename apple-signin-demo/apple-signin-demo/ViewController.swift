//
//  ViewController.swift
//  apple-signin-demo
//
//  Created by Mobile Security Center on 23/06/2019.
//  Copyright © 2019 Mobile Security Center. All rights reserved.
//

import UIKit
import AuthenticationServices


class ViewController: UIViewController {

    @IBOutlet weak var appleSigninView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let myAuthorButton = ASAuthorizationAppleIDButton()
        myAuthorButton.addTarget(self, action: #selector(onAuthorizationButtonClick), for: .touchUpInside)
        let centerX = self.appleSigninView.frame.size.width / 2
        let centerY = self.appleSigninView.frame.size.height / 2
        myAuthorButton.center = CGPoint(x: centerX, y: centerY)
        self.appleSigninView.addSubview(myAuthorButton)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performExistingAccountSetupFlows()
    }

    /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    @objc func onAuthorizationButtonClick() {
        print(#function)
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            // Create an account in your system.
            // For the purpose of this demo app, store the userIdentifier in the keychain.
            do {
//                try KeychainItem(service: "com.example.apple-samplecode.juice", account: "userIdentifier").saveItem(userIdentifier)
                print("user : ", userIdentifier)
            } catch {
                print("Unable to save userIdentifier to keychain.")
            }
            
            // For the purpose of this demo app, show the Apple ID credential information in the ResultViewController.
            let alert = UIAlertController(title: "Apple ID info", message: "user : " + userIdentifier, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
//            if let viewController = self.presentingViewController as? ResultViewController {
//                DispatchQueue.main.async {
//                    viewController.userIdentifierLabel.text = userIdentifier
//                    if let givenName = fullName?.givenName {
//                        viewController.givenNameLabel.text = givenName
//                    }
//                    if let familyName = fullName?.familyName {
//                        viewController.familyNameLabel.text = familyName
//                    }
//                    if let email = email {
//                        viewController.emailLabel.text = email
//                    }
//                    self.dismiss(animated: true, completion: nil)
//                }
//            }
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
                let alertController = UIAlertController(title: "Keychain Credential Received",
                                                        message: message,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
