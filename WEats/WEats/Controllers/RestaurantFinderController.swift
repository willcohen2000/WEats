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
import DropDown
import TransitionButton

class RestaurantFinderController: UIViewController {
    
    @IBOutlet weak var priceSelectionHolderView: UIView!
    @IBOutlet weak var firstDollar: UILabel!
    @IBOutlet weak var secondDollar: UILabel!
    @IBOutlet weak var thirdDollar: UILabel!
    @IBOutlet weak var fourthDollar: UILabel!
    @IBOutlet weak var fifthDollar: UILabel!
    @IBOutlet weak var yesShadowView: UIView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noShadowView: UIView!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var categorySelectionView: UIView!
    @IBOutlet weak var selectTypeOfRestaurantButton: UIButton!
    @IBOutlet weak var restaurantTypeDropdownFrameView: UIView!
    @IBOutlet weak var findRestaurantsButton: TransitionButton!
    
    let blueColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0);
    let blueColorLowAlpha = UIColor(red:0.20, green:0.29, blue:0.37, alpha:0.7);
    let blueTrackColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:0.4);
    let offWhiteColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0);
    var slider: CircularSlider?
    let dropDown = DropDown();
    var currentRestaurantFind = RestaurantCriteria();
    var foundRestaurants = [FinderRestaurant]();
    
    struct RestaurantCriteria {
        var priceRange: Int!
        var category: String!
        var order: Bool!
        init() {
            priceRange = 1;
            category = "Unsure";
            order = false;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupPriceSlider();
        buildView();
        dropDown.hide();
        self.hideKeyboardWhenTappedAround();
        dropDown.anchorView = restaurantTypeDropdownFrameView;
        dropDown.dataSource = Restaurants.restaurantFinderTypes;
        dropDown.selectionAction = { [unowned self] (index: Int, category: String) in
            self.selectTypeOfRestaurantButton.setTitleColor(self.blueColor, for: .normal);
            self.selectTypeOfRestaurantButton.setTitle("\(category) Restaurants", for: .normal);
            self.currentRestaurantFind.category = category;
        }
    }

    private func buildDollarRating(value: Int) {
        var rating = value;
        let numToDollar: [Int:UILabel] = [1: firstDollar, 2: secondDollar, 3: thirdDollar, 4: fourthDollar, 5: fifthDollar];
        for i in 1...5 {
            if (rating >= Int(1)) {
                numToDollar[i]!.alpha = 1.0;
                rating = (rating - 1);
            } else {
                numToDollar[i]!.alpha = 0.5;
                rating = (rating - 1);
            }
        }
    }
    
    private func buildView() {
        firstDollar.alpha = 1.0;
        secondDollar.alpha = 0.5;
        thirdDollar.alpha = 0.5;
        fourthDollar.alpha = 0.5;
        fifthDollar.alpha = 0.5;
        yesShadowView.layer.cornerRadius = (yesShadowView.frame.height / 2);
        noShadowView.layer.cornerRadius = (noShadowView.frame.height / 2);
        yesButton.layer.cornerRadius = (yesButton.frame.height / 2);
        noButton.layer.cornerRadius = (noButton.frame.height / 2);
        yesButton.backgroundColor = offWhiteColor;
        noButton.backgroundColor = offWhiteColor;
        categorySelectionView.layer.cornerRadius = 10.0;
        categorySelectionView.layer.borderColor = blueColor.cgColor;
        categorySelectionView.layer.borderWidth = 1.0;
        findRestaurantsButton.layer.cornerRadius = (findRestaurantsButton.frame.height / 2);
        selectTypeOfRestaurantButton.setTitleColor(blueColorLowAlpha, for: .normal);
    }
    
    private func setupPriceSlider() {
        let circularSlider = CircularSlider(frame: priceSelectionHolderView.frame);
        circularSlider.minimumValue = 0.0;
        circularSlider.maximumValue = 100.0;
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
        circularSlider.center.x = self.view.center.x;
        slider = circularSlider;
        circularSlider.addTarget(self, action: #selector(updatedPrice), for: .valueChanged);
        self.view.addSubview(circularSlider)
    }
    
    @objc func updatedPrice() {
        if let slider = slider {
            let value = Int(slider.endPointValue);
            if (value < 20) {
                buildDollarRating(value: 1);
                currentRestaurantFind.priceRange = 1;
            } else if (value < 40) {
                buildDollarRating(value: 2);
                currentRestaurantFind.priceRange = 2;
            } else if (value < 60) {
                buildDollarRating(value: 3);
                currentRestaurantFind.priceRange = 3;
            } else if (value < 80) {
                buildDollarRating(value: 4);
                currentRestaurantFind.priceRange = 4;
            } else {
                buildDollarRating(value: 5);
                currentRestaurantFind.priceRange = 5;
            }
        }
    }
    
    @IBAction func selectTypeOfRestaurantButtonPressed(_ sender: Any) {
        dropDown.show();
    }
    
    @IBAction func findRestaurantsButtonPressed(_ sender: Any) {
        findRestaurantsButton.startAnimation();
        if (currentRestaurantFind.category != "Unsure") {
            FirebaseService.restaurantFinderPullRestaurantsWithCategory(category: currentRestaurantFind.category, order: currentRestaurantFind.order, priceRange: currentRestaurantFind.priceRange) { (pulledRestaurants) in
                if let pulledRestaurants = pulledRestaurants {
                    self.foundRestaurants = pulledRestaurants;
                    print(pulledRestaurants)
                    self.findRestaurantsButton.stopAnimation(animationStyle: StopAnimationStyle.expand, revertAfterDelay: 0.5, completion: {
                        self.performSegue(withIdentifier: "toFoundRestaurants", sender: nil);
                    })
                }
            }
        } else {
            FirebaseService.restaurantFinderPullRestaurantsNoCategory(order: currentRestaurantFind.order, priceRange: currentRestaurantFind.priceRange, completionHandler: { (pulledRestaurants) in
                if let pulledRestaurants = pulledRestaurants {
                    self.foundRestaurants = pulledRestaurants;
                    self.findRestaurantsButton.stopAnimation(animationStyle: StopAnimationStyle.normal, revertAfterDelay: 0.5, completion: {
                        self.performSegue(withIdentifier: "toFoundRestaurants", sender: nil);
                    })
                }
            })
        }
    }
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        yesButton.backgroundColor = blueColor;
        yesButton.setTitleColor(offWhiteColor, for: .normal);
        noButton.backgroundColor = offWhiteColor;
        noButton.setTitleColor(blueColor, for: .normal);
        currentRestaurantFind.order = true;
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        yesButton.backgroundColor = offWhiteColor;
        yesButton.setTitleColor(blueColor, for: .normal);
        noButton.backgroundColor = blueColor;
        noButton.setTitleColor(offWhiteColor, for: .normal);
        currentRestaurantFind.order = false;
    }
    
}

extension RestaurantFinderController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toFoundRestaurants") {
            if let foundRestaurantsController = segue.destination as? RestaurantFinderResultsController {
                foundRestaurantsController.restaurants = self.foundRestaurants;
            }
        } else {
            if let menuController = segue.destination as? MenuController {
                menuController.incomingController = MenuController.ControllerType.Finder;
            }
        }
    }
}


