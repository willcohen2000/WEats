//
//  Firebase+Service.swift
//  WEats
//
//  Created by Will Cohen on 1/6/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    
    static func pullCurrentlyAllotedCategories(completionHandler: @escaping (_ pulledCategories: [String]?) -> Void) {
        let allotedCategoryReference = Database.database().reference().child("AllotedCategories");
        var pulledCategories = [String]();
        allotedCategoryReference.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for (snap) in snapshot {
                    if (snap.value as! Bool) {
                        pulledCategories.append(snap.key);
                    }
                }
            }
            completionHandler(pulledCategories);
        }) { (error) in
            completionHandler(nil);
        }
    }
    
    static func getRestaurantsByCategory(category: String, completionHandler: @escaping (_ pulledRestaurants: [MiniRestaurant]?) -> Void) {
        let categoryReference = Database.database().reference().child("Categories").child(category);
        var pulledRestaurants = [MiniRestaurant]();
        categoryReference.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for (snap) in snapshot {
                    if let postDict = snap.value as? Dictionary<String,AnyObject> {
                        let key = snap.key;
                        let restaurant = MiniRestaurant(postkey: key, postData: postDict);
                        pulledRestaurants.append(restaurant);
                    }
                }
            }
            completionHandler(pulledRestaurants);
        }) { (error) in
            completionHandler(nil);
        }
    }
    
    static func getFullRestaurantByName(name: String, completionHandler: @escaping (_ restaurant: Restaurant?) -> Void) {
        let restaurantReference = Database.database().reference().child("Restaurants").child(name);
        restaurantReference.observe(.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:];
            guard let address = postDict["address"] else { return };
            guard let description = postDict["description"] else { return };
            guard let doesHaveOnlineOrder = postDict["doesHaveOnlineOrder"] else { return };
            guard let imageURL = postDict["imageUrl"] else { return };
            guard let name = postDict["name"] else { return };
            guard let town = postDict["town"] else { return };
            guard let website = postDict["website"] else { return };
            guard let rating = postDict["rating"] else { return };
            guard let dollarRating = postDict["dollarRating"] else { return };
            completionHandler(Restaurant(name: name as! String, description: description as! String, imageURL: imageURL as! String, doesHaveOnlineOrder: doesHaveOnlineOrder as! Bool, town: town as! String, website: website as! String, address: address as! String, rating: rating as! Float, dollarRating: dollarRating as! Int));
        }) { (error) in
            completionHandler(nil);
        }
        
    }
    
}



