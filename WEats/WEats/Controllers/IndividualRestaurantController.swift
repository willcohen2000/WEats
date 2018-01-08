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
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var firstStarImage: UIImageView!
    @IBOutlet weak var secondStarImage: UIImageView!
    @IBOutlet weak var thirdStarImage: UIImageView!
    @IBOutlet weak var fourthStarImage: UIImageView!
    @IBOutlet weak var fifthStarImage: UIImageView!
    @IBOutlet weak var firstDollar: UILabel!
    @IBOutlet weak var secondDollar: UILabel!
    @IBOutlet weak var thirdDollar: UILabel!
    @IBOutlet weak var fourthDollar: UILabel!
    @IBOutlet weak var fifthDollar: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    
    @IBOutlet weak var restaurantImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var restaurantImageDarkenViewHeight: NSLayoutConstraint!
    
    var restaurantName: String!
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        restaurantImageViewHeight.constant = (self.view.frame.height * 0.45);
        restaurantImageDarkenViewHeight.constant = (self.view.frame.height * 0.45);
        orderButton.layer.cornerRadius = (orderButton.frame.height / 2);
        FirebaseService.getFullRestaurantByName(name: restaurantName) { (restaurant) in
            self.restaurant = restaurant;
            self.buildView();
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func websiteButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func orderButtonPressed(_ sender: Any) {
        
    }
    
    private func buildView() {
        restaurantImageView.sd_setImage(with: URL(string: restaurant.imageURL), completed: nil);
        restaurantNameLabel.text = restaurant.name;
        buildStarRating();
        buildDollarRating();
    }
    
    private func buildDollarRating() {
        var rating = restaurant.dollarRating;
        let numToDollar: [Int:UILabel] = [1: firstDollar, 2: secondDollar, 3: thirdDollar, 4: fourthDollar, 5: fifthDollar];
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
    
    private func buildStarRating() {
        let fullStarImage = UIImage(named: "FilledStar");
        let halfStarImage = UIImage(named: "HalfFilledStar");
        let emptyStarImage = UIImage(named: "EmptyStar");
        var rating = restaurant.rating;
        let numToImage: [Int:UIImageView] = [1: firstStarImage, 2: secondStarImage, 3: thirdStarImage, 4: fourthStarImage, 5: fifthStarImage];
        for i in 1...5 {
            if (rating! >= Float(1)) {
                numToImage[i]!.image = fullStarImage;
                rating = (rating! - 1.0);
            } else if (rating == 0.5) {
                numToImage[i]!.image = halfStarImage;
                rating = (rating! - 1.0);
            } else {
                numToImage[i]!.image = emptyStarImage;
                rating = (rating! - 1.0);
            }
        }
    }

}
