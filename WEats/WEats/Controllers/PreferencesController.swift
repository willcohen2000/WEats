//
//  PreferencesController.swift
//  WEats
//
//  Created by Will Cohen on 1/21/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import UIKit

class PreferencesController: UIViewController {

    @IBOutlet weak var reportTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var buttonTextViewStackView: UIStackView!
    
    let blueColor = UIColor(red:0.22, green:0.29, blue:0.36, alpha:1.0);
    
    override func viewDidLoad() {
        super.viewDidLoad();
        logOutButton.layer.cornerRadius = (logOutButton.frame.height / 2);
        reportTextView.layer.borderColor = blueColor.cgColor;
        reportTextView.layer.borderWidth = 1.0;
        
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        
    }
    
}
