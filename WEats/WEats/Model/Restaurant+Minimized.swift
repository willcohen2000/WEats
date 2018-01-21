//
//  Restaurant+Minimized.swift
//  WEats
//
//  Created by Will Cohen on 1/6/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import Foundation

class MiniRestaurant {
    
    var name: String!
    var description: String!
    var doesHaveOnlineOrder: Bool!
    var address: String!
    var delivery: Bool!
    var postKey: String?

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
        if let name = postData["name"] as? String {
            self.name = name;
        }
        if let delivery = postData["delivery"] as? Bool {
            self.delivery = delivery;
        }
        
    }
    
}
