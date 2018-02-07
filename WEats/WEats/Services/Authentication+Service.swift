//
//  Authentication+Service.swift
//  WEats
//
//  Created by Will Cohen on 12/25/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SwiftKeychainWrapper

class AuthenticationService {
    
    struct FavoriteRestaurant {
        var imageURL: String!
        var name: String!
        
        init(imageURL: String, name: String) {
            self.imageURL = imageURL;
            self.name = name;
        }
        
        init(postData: Dictionary<String, AnyObject>) {
            
            if let name = postData["name"] as? String {
                self.name = name;
            }
            if let imageURL = postData["imageUrl"] as? String {
                self.imageURL = imageURL;
            }
            
        }
        
    }
    
    struct RestaurantAbridged {
        var address: String!
        var name: String!
        
        init(address: String, name: String) {
            self.address = address;
            self.name = name;
        }
        
        init(postData: Dictionary<String, AnyObject>) {
            
            if let name = postData["name"] as? String {
                self.name = name;
            }
            if let address = postData["address"] as? String {
                self.address = address;
            }
            
        }
        
    }
    
    static func getAllRestaurants(completionHandler: @escaping (_ favorites: [RestaurantAbridged]) -> Void) {
        let RestaurantsReference = Database.database().reference().child("RestaurantsAbridged");
        var restaurants = [RestaurantAbridged]();
        RestaurantsReference.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for (snap) in snapshot {
                    if let postDict = snap.value as? Dictionary<String,AnyObject> {
                        let restaurant = RestaurantAbridged(postData: postDict);
                        restaurants.append(restaurant);
                    }
                }
            }
            completionHandler(restaurants);
        }) { (error) in
            completionHandler([]);
        }
    }
    
    static func loadAppInfo(successCompletionHandler: @escaping (_ success: Bool) -> Void) {
        getAllRestaurants(completionHandler: { (allRestaurants) in
            WEUser.sharedInstance.allRestaurants = allRestaurants;
            successCompletionHandler(true);
        })
    }

    
}
