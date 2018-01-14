//
//  MainSelectionControllerViewController.swift
//  WEats
//
//  Created by Will Cohen on 12/15/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

class MainSelectionControllerViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var suggestedRestaurantsCollectionView: UICollectionView!
    @IBOutlet weak var foodGenreCollectionView: UICollectionView!
    
    var openRestaurantCategories = [String]();
    var selectedCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        suggestedRestaurantsCollectionView.delegate = self;
        suggestedRestaurantsCollectionView.dataSource = self;
        foodGenreCollectionView.delegate = self;
        foodGenreCollectionView.dataSource = self;
        foodGenreCollectionView.backgroundView?.backgroundColor = UIColor.clear;
        foodGenreCollectionView.backgroundColor = UIColor.clear;
        FirebaseService.pullCurrentlyAllotedCategories { (pulledCategories) in
            if let pulledCategories = pulledCategories {
                self.openRestaurantCategories = pulledCategories;
                self.foodGenreCollectionView.reloadData();
            }
        }
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
      
    }
    
}

extension MainSelectionControllerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView.tag == 1) {
            return 10;
        } else {
            return openRestaurantCategories.count;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = openRestaurantCategories[indexPath.row];
        selectedCategory = category;
        performSegue(withIdentifier: "toRestaurantSelection", sender: nil);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView.tag == 1) {
            let restaurant = Restaurant(name: "", description: "", imageURL: "", doesHaveOnlineOrder: false, town: "", website: "", address: "", rating: 1.0, dollarRating: 1, phoneNumber: "", hours: [:]);
            if let cell = suggestedRestaurantsCollectionView.dequeueReusableCell(withReuseIdentifier: "suggestedRestaurantCell", for: indexPath) as? SuggestedRestaurantsCell {
                cell.configureCell(restaurant: restaurant, indexPath: indexPath.row);
                return cell;
            } else {
                return SuggestedRestaurantsCell()
            }
        } else {
            if let cell = foodGenreCollectionView.dequeueReusableCell(withReuseIdentifier: "foodGenreCell", for: indexPath) as? FoodGenresCell {
                cell.configureCell(genreName: self.openRestaurantCategories[indexPath.row]);
                return cell;
            } else {
                return FoodGenresCell();
            }
        }
    }
    
}

extension MainSelectionControllerViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toRestaurantSelection") {
            if let selectionController = segue.destination as? RestaurantSelectionController {
                if let selectedCategory = selectedCategory {
                    selectionController.selectedCategory = selectedCategory;
                }
            }
        }
    }
}




