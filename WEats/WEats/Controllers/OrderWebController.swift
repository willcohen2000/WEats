//
//  OrderWebController.swift
//  WEats
//
//  Created by Will Cohen on 1/20/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import UIKit
import WebKit

class OrderWebController: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var orderWebView: WKWebView!
    @IBOutlet weak var orderProgressView: UIProgressView!
    
    var restaurantOrderURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture));
        swipeRight.direction = UISwipeGestureRecognizerDirection.right;
        self.view.addGestureRecognizer(swipeRight);
        orderWebView.navigationDelegate = self;
        orderWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil);
        orderProgressView.transform = orderProgressView.transform.scaledBy(x: 1, y: 3);
        let url = URL(string: restaurantOrderURL);
        let request = URLRequest(url: url!);
        orderWebView.load(request);
        self.hideKeyboardWhenTappedAround();
    }

    @objc private func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if (swipeGesture.direction == .right) {
                self.dismiss(animated: true, completion: nil);
            }
        }
    }
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
}

extension OrderWebController: WKNavigationDelegate {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") { // listen to changes and updated view
            orderProgressView.isHidden = orderWebView.estimatedProgress == 1;
            orderProgressView.setProgress(Float(orderWebView.estimatedProgress), animated: false);
        }
    }
    
}
