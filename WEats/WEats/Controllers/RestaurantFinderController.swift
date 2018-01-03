//
//  RestaurantFinderController.swift
//  WEats
//
//  Created by Will Cohen on 12/30/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import Foundation
import HGCircularSlider

class RestaurantFinderController: UIViewController {
    
    @IBOutlet weak var priceSelectionHolderView: UIView!
    
    let blueColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0);
    let blueTrackColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:0.4);
    let offWhiteColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0);
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupPriceSlider();
    }

    private func setupPriceSlider() {
        let circularSlider = CircularSlider(frame: priceSelectionHolderView.frame);
        circularSlider.minimumValue = 0.0;
        circularSlider.maximumValue = 1.0;
        circularSlider.diskColor = blueColor;
        circularSlider.backgroundColor = .clear;
        circularSlider.diskColor = .clear;
        circularSlider.trackColor = blueTrackColor;
        circularSlider.lineWidth = 30.0;
        circularSlider.backtrackLineWidth = 30.0;
        circularSlider.numberOfRounds = 1;
        circularSlider.trackFillColor = blueColor;
        circularSlider.thumbRadius = 20.0;
        circularSlider.endThumbTintColor = blueColor;
        circularSlider.endThumbStrokeColor = blueColor;
        circularSlider.endThumbStrokeHighlightedColor = blueColor;
        self.view.addSubview(circularSlider)
    }

}
