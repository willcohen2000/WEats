//
//  RestaurantFinderResultsController.swift
//  WEats
//
//  Created by Will Cohen on 1/17/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import UIKit

class RestaurantFinderResultsController: UIViewController {

    @IBOutlet weak var foundRestaurantsTableView: UITableView!
    
    var restaurants: [FinderRestaurant]!
    var selectedRestaurantName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        foundRestaurantsTableView.delegate = self;
        foundRestaurantsTableView.dataSource = self;
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture));
        swipeRight.direction = UISwipeGestureRecognizerDirection.right;
        self.view.addGestureRecognizer(swipeRight);
        self.hideKeyboardWhenTappedAround();
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

extension RestaurantFinderResultsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurantName = restaurants[indexPath.row].name;
        self.selectedRestaurantName = restaurantName;
        self.performSegue(withIdentifier: "toIndivRestaurant", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurant = self.restaurants[indexPath.row];
        if let restaurantCell = foundRestaurantsTableView.dequeueReusableCell(withIdentifier: "foundRestaurantCell") as? FoundRestaurantsCell {
            restaurantCell.buildCell(restaurant: restaurant);
            return restaurantCell;
        } else {
            return FoundRestaurantsCell();
        }
    }
    
}

extension RestaurantFinderResultsController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toIndivRestaurant") {
            if let individualRestaurantController = segue.destination as? IndividualRestaurantController {
                individualRestaurantController.restaurantName = selectedRestaurantName;
            }
        }
    }
}


