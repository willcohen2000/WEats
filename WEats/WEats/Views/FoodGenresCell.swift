//
//  FoodGenresCell.swift
//  WEats
//
//  Created by Will Cohen on 12/27/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

class FoodGenresCell: UICollectionViewCell {
    
    @IBOutlet weak var genreIconImageView: UIImageView!
    @IBOutlet weak var grenreNameLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = (self.frame.width / 2);
    }
    
    func configureCell(genreName: String) {
        grenreNameLabel.text = genreName;
        genreIconImageView.image = Restaurants.restaurantImages[genreName];
    }
    
}
