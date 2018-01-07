//
//  IndividualRestaurantController.swift
//  WEats
//
//  Created by Will Cohen on 1/6/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import UIKit
import SDWebImage

class IndividualRestaurantController: UIViewController {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantImageDarkenView: UIView!
    
    @IBOutlet weak var restaurantImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var restaurantImageDarkenViewHeight: NSLayoutConstraint!
    
    var restaurantName: String!
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        restaurantImageViewHeight.constant = (self.view.frame.height * 0.45);
        restaurantImageDarkenViewHeight.constant = (self.view.frame.height * 0.45);
        FirebaseService.getFullRestaurantByName(name: restaurantName) { (restaurant) in
            self.restaurant = restaurant;
            self.buildView();
        }
    }

    private func buildView() {
        print("hello")
        restaurantImageView.sd_setImage(with: URL(string: restaurant.imageURL), completed: nil);
    }

}
