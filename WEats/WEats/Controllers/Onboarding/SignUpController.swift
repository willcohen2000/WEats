//
//  SignUpController.swift
//  WEats
//
//  Created by Will Cohen on 12/25/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {

    @IBOutlet weak var emailHolderView: UIView!
    @IBOutlet weak var passwordHolderView: UIView!
    @IBOutlet weak var confirmPasswordHolderView: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    let blueColor = UIColor(red:0.22, green:0.29, blue:0.36, alpha:1.0);
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupView(buttons: [emailHolderView, passwordHolderView, confirmPasswordHolderView]);
    }
    
    private func setupView(buttons: [UIView]) {
        emailHolderView.layer.borderColor = blueColor.cgColor;
        emailHolderView.layer.borderWidth = 1.0;
        emailHolderView.layer.cornerRadius = (emailHolderView.frame.height / 2);
        emailHolderView.backgroundColor = UIColor.clear;
        passwordHolderView.layer.borderColor = blueColor.cgColor;
        passwordHolderView.layer.borderWidth = 1.0;
        passwordHolderView.layer.cornerRadius = (passwordHolderView.frame.height / 2);
        passwordHolderView.backgroundColor = UIColor.clear;
        confirmPasswordHolderView.layer.borderColor = blueColor.cgColor;
        confirmPasswordHolderView.layer.borderWidth = 1.0;
        confirmPasswordHolderView.layer.cornerRadius = (passwordHolderView.frame.height / 2);
        confirmPasswordHolderView.backgroundColor = UIColor.clear;
        signUpButton.layer.cornerRadius = (signUpButton.frame.height / 2);
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
    }
    
}