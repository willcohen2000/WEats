//
//  RestaurantSelectionController.swift
//  WEats
//
//  Created by Will Cohen on 1/6/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import UIKit

class RestaurantSelectionController: UIViewController {

    @IBOutlet weak var restaurantSelectionTableView: UITableView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var selectedCategory: String!
    var restaurants = [MiniRestaurant]();
    var selectedRestaurantName: String?
    var orderURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.hideKeyboardWhenTappedAround();
        categoryLabel.text = "\(selectedCategory.capitalized) Restaurants"
        restaurantSelectionTableView.delegate = self;
        restaurantSelectionTableView.dataSource = self;
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture));
        swipeRight.direction = UISwipeGestureRecognizerDirection.right;
        self.view.addGestureRecognizer(swipeRight);
        FirebaseService.getRestaurantsByCategory(category: selectedCategory) { (pulledRestaurants) in
            if let pulledRestaurants = pulledRestaurants {
                self.restaurants = pulledRestaurants;
                self.restaurantSelectionTableView.reloadData();
            }
        }
    }
    
    @objc private func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if (swipeGesture.direction == .right) {
                self.dismiss(animated: true, completion: nil);
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }

}

extension RestaurantSelectionController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurant = self.restaurants[indexPath.row];
        if let restaurantCell = restaurantSelectionTableView.dequeueReusableCell(withIdentifier: "restaurantSelectionCell") as? RestaurantSelectionCell {
            restaurantCell.buildCell(restaurant: restaurant, controller: self);
            restaurantCell.restaurantSelectedDel = self;
            return restaurantCell;
        } else {
            return RestaurantSelectionCell();
        }
    }
    
    func goToOrder(orderURL: String) {
        self.orderURL = orderURL;
        performSegue(withIdentifier: "toOrder", sender: nil);
    }
    
}

extension RestaurantSelectionController: categorySelectionPro {
    func restaurantSelectedCat(_ restaurant: MiniRestaurant) {
        self.selectedRestaurantName = restaurant.name;
        self.performSegue(withIdentifier: "toIndividualRestaurant", sender: nil)
    }
}

extension RestaurantSelectionController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toIndividualRestaurant") {
            if let individualRestaurantController = segue.destination as? IndividualRestaurantController {
                if let selectedRestaurantName = self.selectedRestaurantName {
                    individualRestaurantController.restaurantName = selectedRestaurantName;
                }
            }
        } else {
            if let orderController = segue.destination as? OrderWebController {
                if let orderURL = orderURL {
                    orderController.restaurantOrderURL = orderURL;
                }
            }
        }
    }
}

