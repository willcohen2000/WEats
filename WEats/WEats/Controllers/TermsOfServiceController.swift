//
//  TermsOfServiceController.swift
//  WEats
//
//  Created by Will Cohen on 1/22/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import UIKit

class TermsOfServiceController: UIViewController {

    @IBOutlet weak var pdfWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        if let pdf = Bundle.main.url(forResource: "WEPrivacyPolicy", withExtension: "pdf", subdirectory: nil, localization: nil)  {
            let req = NSURLRequest(url: pdf);
            pdfWebView.loadRequest(req as URLRequest);
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    

}
