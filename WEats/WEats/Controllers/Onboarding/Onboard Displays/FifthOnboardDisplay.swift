//
//  FifthOnboardDisplay.swift
//  WEats
//
//  Created by Will Cohen on 12/25/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import Firebase

protocol fifthDisplayProtocol {
    func fifthFeatureActivated();
}

class FifthOnboardDisplay: UIViewController {

    @IBOutlet weak var emailHolderView: UIView!
    @IBOutlet weak var passwordHolderView: UIView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let blueColor = UIColor(red:0.22, green:0.29, blue:0.36, alpha:1.0);
    var delegate: fifthDisplayProtocol!
    
    override func viewDidAppear(_ animated: Bool) {
        delegate.fifthFeatureActivated();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView();
    }

    private func setupView() {
        emailHolderView.layer.borderColor = blueColor.cgColor;
        emailHolderView.layer.borderWidth = 1.0;
        emailHolderView.layer.cornerRadius = (emailHolderView.frame.height / 2);
        emailHolderView.backgroundColor = UIColor.clear;
        passwordHolderView.layer.borderColor = blueColor.cgColor;
        passwordHolderView.layer.borderWidth = 1.0;
        passwordHolderView.layer.cornerRadius = (passwordHolderView.frame.height / 2);
        passwordHolderView.backgroundColor = UIColor.clear;
        logInButton.layer.cornerRadius = (logInButton.frame.height / 2);
    }
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        guard let USER_EMAIL = emailTextField.text else { return };
        guard let USER_PASSWORD = passwordTextField.text else { return };
        AuthenticationService.logIn(controller: self, userEmail: USER_EMAIL, userPassword: USER_PASSWORD) { (success) in
            if (success) {
                self.performSegue(withIdentifier: "toMain", sender: nil);
            } else {
                // handle
            }
        }
    }
    

}
