//
//  FavoriteRestaurantsController.swift
//  WEats
//
//  Created by Will Cohen on 1/20/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteRestaurantsController: UIViewController {

    @IBOutlet weak var favoriteRestaurantsTableView: UICollectionView!
    @IBOutlet weak var optionsView: UIView!
    
    @IBOutlet weak var menuButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var favoriteRestaurantsLabelTopConstraint: NSLayoutConstraint!
    
    var selectedRestaurant: String?
    let menuTopMargin = 10;
    let favoriteTopMargin = 5;
    var menuCurrentlyUp: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        favoriteRestaurantsTableView.delegate = self;
        favoriteRestaurantsTableView.dataSource = self;
        self.hideKeyboardWhenTappedAround();
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        if (!self.menuCurrentlyUp) {
            self.menuCurrentlyUp = true;
            menuButtonTopConstraint.constant = (CGFloat(menuTopMargin + 150));
            favoriteRestaurantsLabelTopConstraint.constant = (CGFloat(favoriteTopMargin + 150));
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded();
            }) { (success) in
                self.optionsView.isHidden = false;
            }
        } else {
            self.menuCurrentlyUp = false;
            menuButtonTopConstraint.constant = CGFloat(menuTopMargin);
            favoriteRestaurantsLabelTopConstraint.constant = CGFloat(favoriteTopMargin);
            optionsView.isHidden = true;
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded();
            })
        }
    }
    
    @IBAction func favoritesButtonPressed(_ sender: Any) {
        self.menuCurrentlyUp = false;
        menuButtonTopConstraint.constant = CGFloat(menuTopMargin);
        favoriteRestaurantsLabelTopConstraint.constant = CGFloat(favoriteTopMargin);
        optionsView.isHidden = true;
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded();
        })
    }
    

}

extension FavoriteRestaurantsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WEUser.sharedInstance.favoriteRestaurants.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRestaurant = WEUser.sharedInstance.favoriteRestaurants[indexPath.row].name;
        performSegue(withIdentifier: "toIndividualRestaurant", sender: nil);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favoriteRestaurant = WEUser.sharedInstance.favoriteRestaurants[indexPath.row];
        if let cell = favoriteRestaurantsTableView.dequeueReusableCell(withReuseIdentifier: "favoriteRestaurantCell", for: indexPath) as? FavoriteRestaurantCell {
            cell.restaurantImageView.sd_setImage(with: URL(string: favoriteRestaurant.imageURL), completed: nil);
            cell.restaurantNameLabel.text = favoriteRestaurant.name;
            return cell;
        } else {
            return FavoriteRestaurantCell();
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 160.0, height: 160.0)
    }

}

extension FavoriteRestaurantsController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toIndividualRestaurant") {
            if let individualRestaurant = segue.destination as? IndividualRestaurantController {
                individualRestaurant.restaurantName = self.selectedRestaurant;
            }
        } else {
            if let menuController = segue.destination as? MenuController {
                menuController.incomingController = MenuController.ControllerType.Favorite;
            }
        }
    }
}

