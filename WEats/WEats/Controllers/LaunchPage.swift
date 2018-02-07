//
//  LaunchPage.swift
//  WEats
//
//  Created by Will Cohen on 2/5/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import UIKit
import TransitionButton

class LaunchPage: UIViewController {

    @IBOutlet weak var backgroundView: UIVisualEffectView!
    @IBOutlet weak var loadingTransitionButton: TransitionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        loadingTransitionButton.startAnimation();
        AuthenticationService.loadAppInfo { (success) in
            if (success) {
                self.performSegue(withIdentifier: "toExplore", sender: nil);
            }
        }
    }

    

}
