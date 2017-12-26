//
//  SecondOnboardDisplay.swift
//  WEats
//
//  Created by Will Cohen on 12/25/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

protocol secondDisplayProtocol {
    func secondFeatureActivated()
}

class SecondOnboardDisplay: UIViewController {

    var delegate: secondDisplayProtocol!
    
    override func viewDidAppear(_ animated: Bool) {
        delegate.secondFeatureActivated();
    }

}
