//
//  MainSelectionControllerViewController.swift
//  WEats
//
//  Created by Will Cohen on 12/15/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

class MainSelectionControllerViewController: UIViewController {

    @IBOutlet weak var suggestedRestaurantsCollectionView: UICollectionView!
    @IBOutlet weak var foodGenreCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        suggestedRestaurantsCollectionView.delegate = self;
        suggestedRestaurantsCollectionView.dataSource = self;
        foodGenreCollectionView.delegate = self;
        foodGenreCollectionView.dataSource = self;
        foodGenreCollectionView.backgroundView?.backgroundColor = UIColor.clear;
        foodGenreCollectionView.backgroundColor = UIColor.clear;
    }

}

extension MainSelectionControllerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView.tag == 1) {
            return 10;
        } else {
            return Restaurants.restaurantImages.count;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView.tag == 1) {
            let restaurant = Restaurant(name: "", description: "", imageURL: "");
            if let cell = suggestedRestaurantsCollectionView.dequeueReusableCell(withReuseIdentifier: "suggestedRestaurantCell", for: indexPath) as? SuggestedRestaurantsCell {
                cell.configureCell(restaurant: restaurant, indexPath: indexPath.row);
                return cell
            } else {
                return SuggestedRestaurantsCell()
            }
        } else {
            if let cell = foodGenreCollectionView.dequeueReusableCell(withReuseIdentifier: "foodGenreCell", for: indexPath) as? FoodGenresCell {
                cell.configureCell(genreName: Restaurants.restaurantTypes[indexPath.row]);
                return cell;
            } else {
                return FoodGenresCell();
            }
        }
    }
    
    
    
    
}
