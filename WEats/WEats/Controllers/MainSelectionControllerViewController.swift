//
//  MainSelectionControllerViewController.swift
//  WEats
//
//  Created by Will Cohen on 12/15/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import ModernSearchBar

class MainSelectionControllerViewController: UIViewController {
    
    @IBOutlet weak var foodGenreCollectionView: UICollectionView!
    @IBOutlet weak var restaurantSearchBar: ModernSearchBar!
    
    var openRestaurantCategories = [String]();
    var selectedCategory: String?
    let blueColor = UIColor(red:0.22, green:0.29, blue:0.36, alpha:0.5);
    let offWhiteColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0);
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //suggestedRestaurantsCollectionView.delegate = self;
        //suggestedRestaurantsCollectionView.dataSource = self;
        self.restaurantSearchBar.delegateModernSearchBar = self;
        foodGenreCollectionView.delegate = self;
        foodGenreCollectionView.dataSource = self;
        foodGenreCollectionView.backgroundView?.backgroundColor = UIColor.clear;
        foodGenreCollectionView.backgroundColor = UIColor.clear;
        loadSearchAppearance();
        var suggestionList = ["Fortina", "Amore", "Koku", "Little Buddah", "Market North", "North Restaurant", "Tazza", "Granola Bar", "Zerro Otto Nove", "Made In Asia", "Deciccos", "David Chens", "Kira Sushi", "Inka's Seafood Grill"];
        self.restaurantSearchBar.setDatas(datas: suggestionList);
        
        FirebaseService.pullCurrentlyAllotedCategories { (pulledCategories) in
            if let pulledCategories = pulledCategories {
                self.openRestaurantCategories = pulledCategories;
                self.foodGenreCollectionView.reloadData();
            }
        }
    }
    
    private func loadSearchAppearance() {
        self.restaurantSearchBar.searchImage = ModernSearchBarIcon.Icon.none.image;
        self.restaurantSearchBar.suggestionsView_contentViewColor = .white;
        self.restaurantSearchBar.barTintColor = blueColor;
        self.restaurantSearchBar.tintColor = offWhiteColor;
        self.restaurantSearchBar.showsBookmarkButton = false;
        self.restaurantSearchBar.showsCancelButton = false;
        guard let searchField = self.restaurantSearchBar.value(forKey: "searchField") as? UITextField else { return };
        searchField.backgroundColor = UIColor.clear;
        searchField.borderStyle = .none;
        searchField.textColor = offWhiteColor;
        searchField.font = UIFont(name: "Lato-Regular", size: 20);
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
      
    }
    
}

extension MainSelectionControllerViewController: ModernSearchBarDelegate {
    
    func onClickItemSuggestionsView(item: String) {
        print("user touched item: \(item)");
    }

    
}

extension MainSelectionControllerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //  if (collectionView.tag == 1) {
       //     return 10;
       // } else {
            return openRestaurantCategories.count;
      //  }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = openRestaurantCategories[indexPath.row];
        selectedCategory = category;
        performSegue(withIdentifier: "toRestaurantSelection", sender: nil);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /*if (collectionView.tag == 1) {
            let restaurant = Restaurant(name: "", description: "", imageURL: "", doesHaveOnlineOrder: false, town: "", website: "", address: "", rating: 1.0, dollarRating: 1, phoneNumber: "", hours: [:]);
            if let cell = suggestedRestaurantsCollectionView.dequeueReusableCell(withReuseIdentifier: "suggestedRestaurantCell", for: indexPath) as? SuggestedRestaurantsCell {
                cell.configureCell(restaurant: restaurant, indexPath: indexPath.row);
                return cell;
            } else {
                return SuggestedRestaurantsCell()
            }
        } else {
           */ if let cell = foodGenreCollectionView.dequeueReusableCell(withReuseIdentifier: "foodGenreCell", for: indexPath) as? FoodGenresCell {
                cell.configureCell(genreName: self.openRestaurantCategories[indexPath.row]);
                return cell;
            } else {
                return FoodGenresCell();
            }
       // }
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




