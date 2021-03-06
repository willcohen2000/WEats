//
//  MenuController.swift
//  WEats
//
//  Created by Will Cohen on 12/30/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

class MenuController: UIViewController {

    @IBOutlet weak var exploreButton: UIButton!
    @IBOutlet weak var finderButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    enum ControllerType {
        case Explorer
        case Finder
        case Favorite
        case Preferences
    }
    
    
    var incomingController: ControllerType!
    let blueColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0);
    let offWhiteColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0);
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.hideKeyboardWhenTappedAround();
        var buttons = [ControllerType.Explorer: exploreButton!, ControllerType.Finder: finderButton!, ControllerType.Favorite: searchButton!, ControllerType.Preferences: settingsButton!];
        let highlightedButton = buttons[incomingController];
        highlightedButton?.backgroundColor = blueColor;
        highlightedButton?.setTitleColor(offWhiteColor, for: .normal);
        
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    private func changeButtonColors(selectedOption: UIButton) {
        let options = [exploreButton, finderButton, searchButton, settingsButton];
        for (option) in options {
            if (option == selectedOption) {
                option?.backgroundColor = blueColor;
                option?.setTitleColor(offWhiteColor, for: .normal);
            } else {
                option?.backgroundColor = offWhiteColor;
                option?.setTitleColor(blueColor, for: .normal);
            }
        }
    }
    
    @IBAction func exploreRestaurantButtonPressed(_ sender: Any) {
        changeButtonColors(selectedOption: exploreButton);
    }
    
    @IBAction func finderButtonPressed(_ sender: Any) {
        changeButtonColors(selectedOption: finderButton);
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        changeButtonColors(selectedOption: searchButton);
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        changeButtonColors(selectedOption: settingsButton);
    }
    
}
