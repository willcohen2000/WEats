//
//  PreOrderingController.swift
//  WEats
//
//  Created by Will Cohen on 1/2/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import UIKit

class PreOrderingController: UIViewController {

    @IBOutlet weak var yesButton: UIButton! // DELIVERY BUTTON
    @IBOutlet weak var noButton: UIButton!  // PICKUP BUTTON
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var addressHolderView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var addressHolderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var addressLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var addressTextFieldHeight: NSLayoutConstraint!
    
    let blueColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0);
    let offWhiteColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0);
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupView();
    }
    
    private func buildButtons() {
        let buttons: [UIButton] = [yesButton, noButton, continueButton];
        for (button) in buttons {
            button.layer.cornerRadius = button.frame.height / 2;
            button.layer.borderColor = blueColor.cgColor;
            button.layer.borderWidth = 1.0;
            button.backgroundColor = UIColor.clear;
            button.setTitleColor(blueColor, for: .normal);
        }
    }
    
    private func setupView() {
        buildButtons();
        addressHolderViewHeight.constant = 0;
        addressLabelHeight.constant = 0;
        addressTextFieldHeight.constant = 0;
        addressTextField.layer.cornerRadius = 10.0;
        addressTextField.layer.borderColor = blueColor.cgColor;
        addressTextField.layer.borderWidth = 1.0;
        continueButton.backgroundColor = blueColor;
        continueButton.setTitleColor(offWhiteColor, for: .normal);
        self.view.layoutIfNeeded();
    }

    @IBAction func yesButtonPressed(_ sender: Any) {
        addressHolderViewHeight.constant = 100;
        addressLabelHeight.constant = 25;
        addressTextFieldHeight.constant = 50;
        yesButton.backgroundColor = blueColor;
        yesButton.setTitleColor(offWhiteColor, for: .normal);
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded();
        })
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        yesButton.backgroundColor = UIColor.clear;
        yesButton.setTitleColor(blueColor, for: .normal);
        noButton.backgroundColor = blueColor;
        noButton.setTitleColor(offWhiteColor, for: .normal);
        
        addressHolderViewHeight.constant = 0;
        addressLabelHeight.constant = 0;
        addressTextFieldHeight.constant = 0;
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded();
        })
    }

    @IBAction func skipButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        
    }
    
}
