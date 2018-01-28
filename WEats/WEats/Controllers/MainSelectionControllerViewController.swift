//
//  MainSelectionControllerViewController.swift
//  WEats
//
//  Created by Will Cohen on 12/15/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import SearchTextField

class MainSelectionControllerViewController: UIViewController {
    
    @IBOutlet weak var foodGenreCollectionView: UICollectionView!
    @IBOutlet weak var restaurantSearchBar: SearchTextField!
    @IBOutlet weak var optionsView: UIView!
    
    @IBOutlet weak var menuButtonTopMargin: NSLayoutConstraint!
    @IBOutlet weak var exploreRestaurantsTopMargin: NSLayoutConstraint!
    
    let menuButtonMargin = 7;
    let exploreLabelMargin = 3;
    var openRestaurantCategories = [String]();
    var selectedCategory: String?
    var selectedRestaurant: String?
    let blueColor = UIColor(red:0.22, green:0.29, blue:0.36, alpha:1.0);
    let blueColorContainer = UIColor(red:0.22, green:0.29, blue:0.36, alpha:0.95);
    let offWhiteColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0);
    var menuCurrentlyUp: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //suggestedRestaurantsCollectionView.delegate = self;
        //  suggestedRestaurantsCollectionView.dataSource = self;
        foodGenreCollectionView.delegate = self;
        foodGenreCollectionView.dataSource = self;
        foodGenreCollectionView.backgroundView?.backgroundColor = UIColor.clear;
        foodGenreCollectionView.backgroundColor = UIColor.clear;
        loadSearchAppearance();
        self.hideKeyboardWhenTappedAround();
        var suggestionList = [SearchTextFieldItem]();
        
        for (restaurant) in WEUser.sharedInstance.allRestaurants {
            suggestionList.append(SearchTextFieldItem(title: restaurant.name, subtitle: restaurant.address));
        }
        
        self.restaurantSearchBar.filterItems(suggestionList);
        
        self.restaurantSearchBar.itemSelectionHandler = { filteredResults, itemPos in
            let restaurantName = filteredResults[itemPos].title;
            self.selectedRestaurant = restaurantName;
            self.performSegue(withIdentifier: "toIndividiualRestaurant", sender: nil);
        }
        
        FirebaseService.pullCurrentlyAllotedCategories { (pulledCategories) in
            if let pulledCategories = pulledCategories {
                self.openRestaurantCategories = pulledCategories;
                self.foodGenreCollectionView.reloadData();
            }
        }
    }
    
    private func loadSearchAppearance() {
        self.restaurantSearchBar.theme.font = UIFont(name: "Lato-Regular", size: 20)!;
        self.restaurantSearchBar.theme.separatorColor = blueColor;
        self.restaurantSearchBar.comparisonOptions = [.caseInsensitive];
        self.restaurantSearchBar.theme.bgColor = blueColorContainer;
        self.restaurantSearchBar.theme.borderColor = blueColor;
        self.restaurantSearchBar.theme.fontColor = offWhiteColor;
        self.restaurantSearchBar.setLeftPaddingPoints(10);
        self.restaurantSearchBar.highlightAttributes = [NSAttributedStringKey.backgroundColor: UIColor.clear, NSAttributedStringKey.font: UIFont(name: "Lato-Bold", size: 20)!];
        self.restaurantSearchBar.theme.cellHeight = 70;
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        if (!self.menuCurrentlyUp) {
            self.menuCurrentlyUp = true;
            menuButtonTopMargin.constant = (CGFloat(menuButtonMargin + 150));
            exploreRestaurantsTopMargin.constant = (CGFloat(exploreLabelMargin + 150));
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded();
            }) { (success) in
                self.optionsView.isHidden = false;
            }
        } else {
            self.menuCurrentlyUp = false;
            menuButtonTopMargin.constant = CGFloat(menuButtonMargin);
            exploreRestaurantsTopMargin.constant = CGFloat(exploreLabelMargin);
            optionsView.isHidden = true;
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded();
            })
        }
    }
    
    @IBAction func exploreButtonPressed(_ sender: Any) {
        menuButtonTopMargin.constant = CGFloat(menuButtonMargin);
        exploreRestaurantsTopMargin.constant = CGFloat(exploreLabelMargin);
        optionsView.isHidden = true;
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded();
        })
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
        } else if (segue.identifier == "toMenu") {
            if let menuController = segue.destination as? MenuController {
                menuController.incomingController = MenuController.ControllerType.Explorer;
            }
        } else {
            if let restaurantController = segue.destination as? IndividualRestaurantController {
                if let selectedRestaurant = selectedRestaurant {
                    restaurantController.restaurantName = selectedRestaurant;
                }
            }
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}


