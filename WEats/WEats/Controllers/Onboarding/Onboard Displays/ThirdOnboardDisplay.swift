//
//  ThirdOnboardDisplay.swift
//  WEats
//
//  Created by Will Cohen on 12/25/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

protocol thirdDisplayProtocol {
    func thirdFeatureActivated();
}

class ThirdOnboardDisplay: UIViewController {

    var delegate: thirdDisplayProtocol!
    
    override func viewDidAppear(_ animated: Bool) {
        delegate.thirdFeatureActivated();
    }

}
