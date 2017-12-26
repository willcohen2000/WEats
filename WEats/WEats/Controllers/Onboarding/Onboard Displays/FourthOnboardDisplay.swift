//
//  FourthOnboardDisplay.swift
//  WEats
//
//  Created by Will Cohen on 12/25/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

protocol fourthDisplayProtocol {
    func fourthFeatureActivated();
}

class FourthOnboardDisplay: UIViewController {

    var delegate: fourthDisplayProtocol!
    
    override func viewDidAppear(_ animated: Bool) {
        delegate.fourthFeatureActivated();
    }

}
