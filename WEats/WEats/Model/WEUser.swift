//
//  WEUser.swift
//  WEats
//
//  Created by Will Cohen on 12/25/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import Foundation

final class WEUser {
    
    static let sharedInstance = WEUser();
    private init() {}
    
    var uid: String!
    var favoriteRestaurants: [AuthenticationService.FavoriteRestaurant]!
    var allRestaurants: [AuthenticationService.RestaurantAbridged]!
    
}
