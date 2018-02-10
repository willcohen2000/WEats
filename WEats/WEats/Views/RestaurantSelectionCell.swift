//
//  RestaurantSelectionCell.swift
//  WEats
//
//  Created by Will Cohen on 1/6/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import UIKit

protocol categorySelectionPro {
    func restaurantSelectedCat(_ restaurant: MiniRestaurant);
}

class RestaurantSelectionCell: UITableViewCell {

    @IBOutlet weak var interiorHolderView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantDescriptionLabel: VerticalTopAlignLabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var deliveryIconImageView: UIImageView!
    
    var controller: RestaurantSelectionController!
    var restaurant: MiniRestaurant!
    var restaurantSelectedDel: categorySelectionPro!
    
    override func awakeFromNib() {
        super.awakeFromNib();
        shadowView.layer.cornerRadius = 10.0;
        interiorHolderView.layer.cornerRadius = 10.0;
        orderButton.layer.cornerRadius = 16;
    }

    func buildCell(restaurant: MiniRestaurant, controller: RestaurantSelectionController) {
        self.restaurant = restaurant;
        self.restaurantNameLabel.text = restaurant.name;
        self.restaurantDescriptionLabel.text = restaurant.description;
        self.restaurantAddressLabel.text = restaurant.address;
        self.controller = controller;
        if (!restaurant.doesHaveOnlineOrder) {
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
    
    @IBAction func orderButtonPressed(_ sender: Any) {
        controller.goToOrder(orderURL: restaurant.orderURL);
    }
    
    @IBAction func restaurantSelectedPressed(_ sender: Any) {
        if let restaurantSelectedDel = restaurantSelectedDel {
            restaurantSelectedDel.restaurantSelectedCat(self.restaurant);
        }
    }
    
}
