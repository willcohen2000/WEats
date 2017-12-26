//
//  FirstOnboardDisplay.swift
//  WEats
//
//  Created by Will Cohen on 12/25/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

protocol firstDisplayProtocol {
    func firstFeatureActivated();
}

class FirstOnboardDisplay: UIViewController {

    var delegate: firstDisplayProtocol!
    
    override func viewDidAppear(_ animated: Bool) {
        delegate.firstFeatureActivated();
    }
    
}
