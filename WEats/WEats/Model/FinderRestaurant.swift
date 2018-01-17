//
//  FinderRestaurant.swift
//  WEats
//
//  Created by Will Cohen on 1/17/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import Foundation

class FinderRestaurant {
    
    var name: String!
    var price: Int!
    var order: Bool!
    
    init(postData: Dictionary<String, AnyObject>) {
        
        if let name = postData["name"] as? String {
            self.name = name;
        }
        if let order = postData["order"] as? Bool {
            self.order = order;
        }
        if let price = postData["price"] as? Int {
            self.price = price;
        }
        
    }
    
}
