//
//  SuggestedRestaurantsCell.swift
//  WEats
//
//  Created by Will Cohen on 12/15/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import SDWebImage

class SuggestedRestaurantsCell: UICollectionViewCell {
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var suggestedRestaurantNumberHolderView: UIView!
    @IBOutlet weak var suggestedRestaurantNumberLabel: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantDescription: UITextView!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 20.0;
        suggestedRestaurantNumberHolderView.layer.cornerRadius = (suggestedRestaurantNumberHolderView.frame.height / 2);
        suggestedRestaurantNumberHolderView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4);
    }
    
    func configureCell(restaurant: Restaurant, indexPath: Int) {
        holderView.layer.cornerRadius = 20.0;
        holderView.clipsToBounds = true;
        self.restaurantImage.sd_setImage(with: URL(string: "https://www.whattododigital.com/wp-content/uploads/2016/02/koku_bar.jpg"));
        self.restaurantName.text = "Koku";
        self.restaurantDescription.text = "Modern, intimate, and upbeat New York City vibes are just a few concepts to name that we will intertwine and bring into Armonk and to the residents of upstate New York.";
        self.suggestedRestaurantNumberLabel.text = "\((indexPath + 1))";
    }
    
    @IBAction func directionsButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func orderButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func reviewsButtonPressed(_ sender: Any) {
        
    }
    
}
