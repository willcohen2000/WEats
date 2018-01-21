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
    var address: String!
    var description: String!
    var delivery: Bool!
    
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
        if let address = postData["address"] as? String {
            self.address = address;
        }
        if let description = postData["description"] as? String {
            self.description = description;
        }
        if let delivery = postData["delivery"] as? Bool {
            self.delivery = delivery;
        }
        
    }
    
}
