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


    @objc func onAuthorizationButtonClick() {
        print(#function)
    }
}

