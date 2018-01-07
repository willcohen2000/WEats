//
//  Restaurant.swift
//  WEats
//
//  Created by Will Cohen on 12/15/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import Foundation
import SDWebImage

class Restaurant {
    
    var name: String!
    var description: String!
    var imageURL: String!
    var doesHaveOnlineOrder: Bool!
    var town: String!
    var website: String!
    var address: String!
    var rating: Float!
    var postKey: String?
    
    init(name: String, description: String, imageURL: String, doesHaveOnlineOrder: Bool, town: String, website: String, address: String, rating: Float) {
        self.name = name;
        self.description = description;
        self.imageURL = imageURL;
        self.doesHaveOnlineOrder = doesHaveOnlineOrder;
        self.town = town;
        self.website = website;
        self.address = address;
        self.rating = rating;
    }
    
    init(postkey: String, postData: Dictionary<String, AnyObject>) {
        self.postKey = postkey;
        
        if let address = postData["address"] as? String {
            self.address = address;
        }
        if let description = postData["description"] as? String {
            self.description = description;
        }
        if let doesHaveOnlineOrder = postData["doesHaveOnlineOrder"] as? Bool {
            self.doesHaveOnlineOrder = doesHaveOnlineOrder;
        }
        if let imageUrl = postData["imageUrl"] as? String {
            self.imageURL = imageUrl;
        }
        if let name = postData["name"] as? String {
            self.name = name;
        }
        if let town = postData["town"] as? String {
            self.town = town;
        }
        if let website = postData["website"] as? String {
            self.website = website;
        }
        if let rating = postData["rating"] as? Float {
            self.rating = rating;
        }
    }
    
}
