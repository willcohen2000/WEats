//
//  SuggestedRestaurantsCell.swift
//  WEats
//
//  Created by Will Cohen on 12/15/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

class SuggestedRestaurantsCell: UICollectionViewCell {
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var suggestedRestaurantNumberHolderView: UIView!
    @IBOutlet weak var suggestedRestaurantNumberLabel: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantDescription: UITextView!
    @IBOutlet weak var holderView: UIView!
    
    func configureCell(restaurant: Restaurant) {
        holderView.layer.cornerRadius = 20.0;
        holderView.clipsToBounds = true;
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        layer.cornerRadius = 20.0;
        layer.shadowRadius = 2;
        layer.shadowOpacity = 0.8;
        layer.shadowOffset = CGSize(width: 5, height: 10);
        self.clipsToBounds = false;
    }
    
    @IBAction func directionsButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func orderButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func reviewsButtonPressed(_ sender: Any) {
        
    }
    
}
