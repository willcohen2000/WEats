//
//  IndividualRestaurantController.swift
//  WEats
//
//  Created by Will Cohen on 1/6/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import Alamofire
import SwiftyUserDefaults

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
    @IBOutlet weak var addressLabel: VerticalTopAlignLabel!
    @IBOutlet weak var phoneLabel: VerticalTopAlignLabel!
    @IBOutlet weak var hoursTableView: UITableView!
    @IBOutlet weak var favoriteRestaurantButton: UIButton!
    
    @IBOutlet weak var restaurantImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var restaurantImageDarkenViewHeight: NSLayoutConstraint!

    var restaurantName: String!
    var restaurant: Restaurant!
    var didBuild: Bool = false;
    var hourDayNames: [String] = ["","","","","","",""];
    var hourHours: [String] = ["","","","","","",""];
    var favorited: Bool = false;
    var webURL: String?
    let blueColor = UIColor(red:0.22, green:0.29, blue:0.36, alpha: 1.0);
    let offWhiteColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0);
    let currentDay: String = Date().dayNumberOfWeek();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.hideKeyboardWhenTappedAround();
        hoursTableView.delegate = self;
        hoursTableView.dataSource = self;
        restaurantImageViewHeight.constant = (self.view.frame.height * 0.45);
        restaurantImageDarkenViewHeight.constant = (self.view.frame.height * 0.45);
        orderButton.layer.cornerRadius = (orderButton.frame.height / 2);
        favoriteRestaurantButton.layer.cornerRadius = (favoriteRestaurantButton.frame.height / 2);
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture));
        swipeRight.direction = UISwipeGestureRecognizerDirection.right;
        self.view.addGestureRecognizer(swipeRight);
        FirebaseService.getFullRestaurantByName(name: restaurantName) { (restaurant) in
            if (!(restaurant?.doesHaveOnlineOrder)!) {
                self.orderButton.isHidden = true;
            }
            self.restaurant = restaurant;
            if (self.isFavorited()) {
                self.favorited = true;
                self.favoriteStyle();
            }
            self.buildView();
            self.didBuild = true;
            self.getHoursArray();
            self.hoursTableView.reloadData();
        }
    }
    
    @objc private func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if (swipeGesture.direction == .right) {
                self.dismiss(animated: true, completion: nil);
            }
        }
    }
    
    private func removeRestaurantAsFavorite() {
        Defaults[.favorites].removeValue(forKey: restaurant.name);
    }
    
    private func setHour(index: Int, hour: String, day: String) {
        hourHours[index] = day;
        hourDayNames[index] = hour;
    }
    
    private func getHoursArray() {
        for (hourBlock) in self.restaurant.hours {
            switch (hourBlock.key) {
            case "Monday":
                setHour(index: 0, hour: hourBlock.key, day: hourBlock.value);
            case "Tuesday":
                setHour(index: 1, hour: hourBlock.key, day: hourBlock.value);
            case "Wednesday":
                setHour(index: 2, hour: hourBlock.key, day: hourBlock.value);
            case "Thursday":
                setHour(index: 3, hour: hourBlock.key, day: hourBlock.value);
            case "Friday":
                setHour(index: 4, hour: hourBlock.key, day: hourBlock.value);
            case "Saturday":
                setHour(index: 5, hour: hourBlock.key, day: hourBlock.value);
            case "Sunday":
                setHour(index: 5, hour: hourBlock.key, day: hourBlock.value);
            default:
                setHour(index: 0, hour: "", day: "");
            }
        }
    }
    
    private func favoriteStyle() {
        favoriteRestaurantButton.setTitle("Favorited", for: .normal);
        favoriteRestaurantButton.setTitleColor(blueColor, for: .normal);
        favoriteRestaurantButton.backgroundColor = UIColor.white;
    }
    
    private func unfavoriteStyle() {
        favoriteRestaurantButton.setTitle("Favorite Restaurant", for: .normal);
        favoriteRestaurantButton.setTitleColor(offWhiteColor, for: .normal);
        favoriteRestaurantButton.backgroundColor = UIColor.clear;
        favoriteRestaurantButton.layer.borderColor = offWhiteColor.cgColor;
        favoriteRestaurantButton.layer.borderWidth = 1.0;
    }
    
    @IBAction func favoriteRestaurantButtonPressed(_ sender: Any) {
        if (favorited) {
            favorited = false;
            unfavoriteStyle();
            removeRestaurantAsFavorite();
        } else {
            favorited = true;
            favoriteStyle();
            Defaults[.favorites][restaurant.name] = restaurant.imageURL;
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func websiteButtonPressed(_ sender: Any) {
        webURL = restaurant.website;
        print(restaurant.website)
        performSegue(withIdentifier: "toOrderView", sender: nil);
    }
    
    @IBAction func orderButtonPressed(_ sender: Any) {
        webURL = restaurant.orderURL;
        performSegue(withIdentifier: "toOrderView", sender: nil);
    }
    
    private func buildView() {
        restaurantImageView.sd_setImage(with: URL(string: restaurant.imageURL!), completed: nil);
        restaurantNameLabel.text = restaurant.name;
        addressLabel.text = restaurant.address;
        phoneLabel.text = restaurant.phoneNumber;
        buildStarRating();
        buildDollarRating();
        favoriteRestaurantButton.layer.cornerRadius = (favoriteRestaurantButton.frame.height / 2);
        favoriteRestaurantButton.layer.borderColor = offWhiteColor.cgColor;
        favoriteRestaurantButton.layer.borderWidth = 1.0;
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
    
    private func isFavorited() -> Bool {
        for (favoriteRestaurant) in Defaults[.favorites] {
            print(favoriteRestaurant.key);
            print(restaurant.name);
            if (favoriteRestaurant.key == restaurant.name) {
                return true;
            }
        }
        return false;
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

extension IndividualRestaurantController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toOrderView") {
            if let orderController = segue.destination as? OrderWebController {
                if let webURL = webURL {
                    orderController.restaurantOrderURL = self.webURL;
                }
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
            if (self.hourDayNames[indexPath.row] == currentDay) {
                hoursCell.dayOfWeekLabel.font = UIFont(name: "Lato-Bold", size: hoursCell.dayOfWeekLabel.font.pointSize)
                hoursCell.hoursLabel.font = UIFont(name: "Lato-Bold", size: hoursCell.dayOfWeekLabel.font.pointSize)
            }
            return hoursCell;
        } else {
            return RestaurantHoursCell();
        }
    }
    
}

extension Date {
    func dayNumberOfWeek() -> String {
        let intDate = Calendar.current.dateComponents([.weekday], from: self).weekday;
        switch (intDate!) {
        case 1:
            return "Sunday";
        case 2:
            return "Monday";
        case 3:
            return "Tuesday";
        case 4:
            return "Wednesday";
        case 5:
            return "Thursday";
        case 6:
            return "Friday";
        case 7:
            return "Saturday";
        default:
            return "";
        }
    }
}


