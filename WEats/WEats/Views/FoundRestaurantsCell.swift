//
//  FoundRestaurantsCell.swift
//  WEats
//
//  Created by Will Cohen on 1/17/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import UIKit

protocol foundRestaurantPro {
    func restaurantSelectedFidner(_ restaurant: FinderRestaurant);
}

class FoundRestaurantsCell: UITableViewCell {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantDescriptionLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var oneDollarLabel: UILabel!
    @IBOutlet weak var twoDollarLabel: UILabel!
    @IBOutlet weak var threeDollarLabel: UILabel!
    @IBOutlet weak var fourDollarLabel: UILabel!
    @IBOutlet weak var fiveDollarLabel: UILabel!
    @IBOutlet weak var shadowHolderView: UIView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var deliveryIconImageView: UIImageView!
    
    var restaurant: FinderRestaurant!
    var restaurantSelectedFinderDelegate: foundRestaurantPro!
    
    override func awakeFromNib() {
        super.awakeFromNib();
        shadowHolderView.layer.cornerRadius = 10.0;
        holderView.layer.cornerRadius = 10.0;
        orderButton.layer.cornerRadius = (orderButton.frame.height / 2);
    }
    
    func buildCell(restaurant: FinderRestaurant) {
        self.restaurant = restaurant;
        self.restaurantNameLabel.text = restaurant.name;
        self.restaurantDescriptionLabel.text = restaurant.description;
        self.restaurantAddressLabel.text = restaurant.address;
        buildDollarRating();
        if (!restaurant.order) {
            orderButton.isHidden = true;
        } else {
            orderButton.isHidden = false;
        }
        if (!restaurant.delivery) {
            self.deliveryIconImageView.isHidden = true;
        } else {
            self.deliveryIconImageView.isHidden = false;
        }
    }
    
    private func buildDollarRating() {
        var rating = restaurant.price;
        let numToDollar: [Int:UILabel] = [1: oneDollarLabel, 2: twoDollarLabel, 3: threeDollarLabel, 4: fourDollarLabel, 5: fiveDollarLabel];
        for i in 1...5 {
            if (rating! >= Int(1)) {
                numToDollar[i]!.alpha = 1.0;
                rating = (rating! - 1);
            } else {
                numToDollar[i]!.alpha = 0.5;
                rating = (rating! - 1);
            }
        }
    }
    @IBAction func restaurantSelectedPressedFind(_ sender: Any) {
        if let restaurantSelectedFinderDelegate = restaurantSelectedFinderDelegate {
            restaurantSelectedFinderDelegate.restaurantSelectedFidner(restaurant);
        }
    }
    
    @IBAction func orderButtonPressed(_ sender: Any) {
        
    }
    
}
