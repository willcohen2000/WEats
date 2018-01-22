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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.hideKeyboardWhenTappedAround();
        categoryLabel.text = "\(selectedCategory.capitalized) Restaurants"
        restaurantSelectionTableView.delegate = self;
        restaurantSelectionTableView.dataSource = self;
        FirebaseService.getRestaurantsByCategory(category: selectedCategory) { (pulledRestaurants) in
            if let pulledRestaurants = pulledRestaurants {
                self.restaurants = pulledRestaurants;
                self.restaurantSelectionTableView.reloadData();
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurantName = restaurants[indexPath.row].name;
        self.selectedRestaurantName = restaurantName;
        self.performSegue(withIdentifier: "toIndividualRestaurant", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurant = self.restaurants[indexPath.row];
        if let restaurantCell = restaurantSelectionTableView.dequeueReusableCell(withIdentifier: "restaurantSelectionCell") as? RestaurantSelectionCell {
            restaurantCell.buildCell(restaurant: restaurant);
            return restaurantCell;
        } else {
            return RestaurantSelectionCell();
        }
    }
    
}

extension RestaurantSelectionController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toIndividualRestaurant") {
            if let individualRestaurantController = segue.destination as? IndividualRestaurantController {
                if selectedRestaurantName == self.selectedRestaurantName {
                    individualRestaurantController.restaurantName = selectedRestaurantName;
                }
            }
        }
    }
}

