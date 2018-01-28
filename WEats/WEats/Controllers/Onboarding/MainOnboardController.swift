//
//  MainOnboardController.swift
//  WEats
//
//  Created by Will Cohen on 12/25/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class MainOnboardController: UIViewController {

    @IBOutlet weak var firstOnboardIndicator: UIView!
    @IBOutlet weak var secondOnboardIndicator: UIView!
    @IBOutlet weak var thirdOnboardIndicator: UIView!
    @IBOutlet weak var fourthOnboardIndicator: UIView!
    @IBOutlet weak var fifthOnboardIndicator: UIView!
    @IBOutlet weak var indicatorStackView: UIStackView!
    
    let blueColor = UIColor(red:0.22, green:0.29, blue:0.36, alpha:1.0);
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.hideKeyboardWhenTappedAround();
    }
    
    func changeIndicator(pageNum: Int) {
        let imageDictionary: [Int:UIView] = [
            0: firstOnboardIndicator,
            1: secondOnboardIndicator,
            2: thirdOnboardIndicator,
            3: fourthOnboardIndicator,
            4: fifthOnboardIndicator
        ];
        
        for (viewNum) in imageDictionary {
            if (viewNum.key == pageNum) {
                if (viewNum.key == 4) {
                    indicatorStackView.isHidden = true;
                } else {
                    indicatorStackView.isHidden = false;
                    viewNum.value.layer.cornerRadius = (viewNum.value.frame.height / 2);
                    viewNum.value.backgroundColor = blueColor;
                }
            } else {
                viewNum.value.layer.cornerRadius = (viewNum.value.frame.height / 2);
                viewNum.value.backgroundColor = UIColor.clear;
                viewNum.value.layer.borderColor = blueColor.cgColor;
                viewNum.value.layer.borderWidth = 0.5;
            }
        }
        
    }

}

extension MainOnboardController: pageChangeProtocol {
    func pageChanged(_ pageNumber: Int) {
        changeIndicator(pageNum: pageNumber);
    }
}

extension MainOnboardController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "containerSegue") {
            if let featurePage = segue.destination as? OnboardingPageController {
                featurePage.pageChange = self;
            }
        }
    }
}
