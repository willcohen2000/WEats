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
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var addressLabel: VerticalTopAlignLabel!
    @IBOutlet weak var phoneLabel: VerticalTopAlignLabel!
    @IBOutlet weak var hoursTableView: UITableView!
    @IBOutlet weak var favoriteRestaurantButton: UIButton!
    
    @IBOutlet weak var restaurantImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var restaurantImageDarkenViewHeight: NSLayoutConstraint!
    
    var restaurantName: String!
    var restaurant: Restaurant!
    var didBuild: Bool = false;
    var hourDayNames = [String]();
    var hourHours = [String]();
    var favorited: Bool = false;
    let blueColor = UIColor(red:0.22, green:0.29, blue:0.36, alpha: 1.0);
    let offWhiteColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0);
    
    override func viewDidLoad() {
        super.viewDidLoad();
        hoursTableView.delegate = self;
        hoursTableView.dataSource = self;
        restaurantImageViewHeight.constant = (self.view.frame.height * 0.45);
        restaurantImageDarkenViewHeight.constant = (self.view.frame.height * 0.45);
        orderButton.layer.cornerRadius = (orderButton.frame.height / 2);
        favoriteRestaurantButton.layer.cornerRadius = (favoriteRestaurantButton.frame.height / 2);
        FirebaseService.getFullRestaurantByName(name: restaurantName) { (restaurant) in
            self.restaurant = restaurant;
            self.buildView();
            self.didBuild = true;
            self.getHoursArray();
            self.hoursTableView.reloadData();
        }
    }
    
    private func getHoursArray() {
        for (hourBlock) in self.restaurant.hours {
            hourDayNames.append(hourBlock.key);
            hourHours.append(hourBlock.value);
        }
    }
    
    @IBAction func favoriteRestaurantButtonPressed(_ sender: Any) {
        if (favorited) {
            favorited = false;
            favoriteRestaurantButton.setTitle("Favorite Restaurant", for: .normal);
            favoriteRestaurantButton.setTitleColor(offWhiteColor, for: .normal);
            favoriteRestaurantButton.backgroundColor = UIColor.clear;
            favoriteRestaurantButton.layer.borderColor = offWhiteColor.cgColor;
            favoriteRestaurantButton.layer.borderWidth = 1.0;
        } else {
            favorited = true;
            favoriteRestaurantButton.setTitle("Favorited", for: .normal);
            favoriteRestaurantButton.setTitleColor(blueColor, for: .normal);
            favoriteRestaurantButton.backgroundColor = UIColor.white;
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func websiteButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func orderButtonPressed(_ sender: Any) {
        
    }
    
    private func buildView() {
        restaurantImageView.sd_setImage(with: URL(string: restaurant.imageURL), completed: nil);
        restaurantNameLabel.text = restaurant.name;
        addressLabel.text = restaurant.address;
        phoneLabel.text = restaurant.phoneNumber;
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

extension IndividualRestaurantController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (!didBuild) {
            return 0;
        }
        return self.restaurant.hours.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let hoursCell = hoursTableView.dequeueReusableCell(withIdentifier: "hoursCell") as? RestaurantHoursCell {
            hoursCell.buildCell(dayOfWeek: self.hourDayNames[indexPath.row], hour: self.hourHours[indexPath.row]);
            return hoursCell;
        } else {
            return RestaurantHoursCell();
        }
    }
    
}
