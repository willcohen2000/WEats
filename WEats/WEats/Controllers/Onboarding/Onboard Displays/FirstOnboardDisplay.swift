//
//  FirstOnboardDisplay.swift
//  WEats
//
//  Created by Will Cohen on 12/25/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import TransitionButton
import SwiftKeychainWrapper

protocol firstDisplayProtocol {
    func firstFeatureActivated();
}

class FirstOnboardDisplay: UIViewController {

    var delegate: firstDisplayProtocol!
    @IBOutlet weak var visualBackgroundView: UIVisualEffectView!
    @IBOutlet weak var loadingButton: TransitionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        visualBackgroundView.isHidden = true;
        if (KeychainWrapper.standard.string(forKey: "uid") != nil) {
            let uid = KeychainWrapper.standard.string(forKey: "uid");
            loadingButton.startAnimation();
            visualBackgroundView.isHidden = false;
            AuthenticationService.loadAppInfo(UID: uid!, successCompletionHandler: { (success) in
                if (success) {
                    self.performSegue(withIdentifier: "toExplore", sender: nil);
                }
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        delegate.firstFeatureActivated();
    }
    
}
