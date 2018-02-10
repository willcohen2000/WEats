//
//  PreferencesController.swift
//  WEats
//
//  Created by Will Cohen on 1/21/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class PreferencesController: UIViewController {

    @IBOutlet weak var reportTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var buttonTextViewStackView: UIStackView!
    @IBOutlet weak var optionsView: UIView!
    
    @IBOutlet weak var menuButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var preferencesLabelTopConstraint: NSLayoutConstraint!
    
    let blueColor = UIColor(red:0.22, green:0.29, blue:0.36, alpha:1.0);
    var menuCurrentlyUp: Bool = false;
    let menuTopMargin = 10;
    let preferencesTopMargin = 5;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        reportTextView.layer.borderColor = blueColor.cgColor;
        reportTextView.layer.borderWidth = 1.0;
        self.hideKeyboardWhenTappedAround();
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
        if (reportTextView.text != "") {
            let reference = Database.database().reference().child("Reports").childByAutoId();
            reference.updateChildValues([
                "Report": reportTextView.text
            ]);
            let alert = UIAlertController(title: "Thank you for reporting!", message: "We appreciate you taking the time to help make WestchesterEats better.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil);
        }
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: "uid");
    }
    
    @IBAction func preferencesButtonPressed(_ sender: Any) {
        self.menuCurrentlyUp = false;
        menuButtonTopConstraint.constant = CGFloat(menuTopMargin);
        preferencesLabelTopConstraint.constant = CGFloat(preferencesTopMargin);
        optionsView.isHidden = true;
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded();
        })
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        if (!self.menuCurrentlyUp) {
            self.menuCurrentlyUp = true;
            menuButtonTopConstraint.constant = (CGFloat(menuTopMargin + 150));
            preferencesLabelTopConstraint.constant = (CGFloat(preferencesTopMargin + 150));
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded();
            }) { (success) in
                self.optionsView.isHidden = false;
            }
        } else {
            self.menuCurrentlyUp = false;
            menuButtonTopConstraint.constant = CGFloat(menuTopMargin);
            preferencesLabelTopConstraint.constant = CGFloat(preferencesTopMargin);
            optionsView.isHidden = true;
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded();
            })
        }
    }
}

extension PreferencesController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toMenu") {
            if let menuController = segue.destination as? MenuController {
                menuController.incomingController = MenuController.ControllerType.Preferences;
            }
        }
    }
}
