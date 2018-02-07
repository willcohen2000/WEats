//
//  Restaurants.swift
//  WEats
//
//  Created by Will Cohen on 12/26/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import Foundation

struct Restaurants {
    
    enum restaurantCharacteristics {
        case Cheap;
        case Expensive;
        case Fancy;
        case Casual;
        case Take_Out;
        case Trendy;
        case Traditional;
        case Upscale;
        case Chic;
        case Crowded;
        case Quiet;
        case Loud;
        case Busy;
        case Slow;
        case Ethnic;
        case Fast_Dining;
        case Fine_Dining;
        case Intimate;
        case Quick_Service;
        case Midscale;
        case Family_Style;
        case Full_Service;
        case Formal;
        case Informal;
        case Café;
        case Bistro;
        case Buffet;
        case Fast_Food;
        case Delivery;
        case Pick_Up;
        case In_Restaurant_Dining;
        case Reservations;
        case A_la_Carte;
        case Bakery;
        case Pizzeria;
        case Elegant;
        case Friendly;
        case Romantic;
        case Family_Friendly;
        case Fun;
    }
    
    static var restaurantTypes: [String] = [
        "BBQ",
        "Burgers",
        "Cafe",
        "Chinese",
        "Indian",
        "Italian",
        "Mexican",
        "Pizza",
        "Salad",
        "Sandwiches",
        "Steak",
        "Sushi",
        "Seafood",
        "Japanese",
        "American"
    ];
    
    static var restaurantFinderTypes: [String] = [
        "No Preference",
        "BBQ",
        "Burgers",
        "Cafe",
        "Chinese",
        "Indian",
        "Italian",
        "Mexican",
        "Pizza",
        "Salad",
        "Sandwiches",
        "Steak",
        "Sushi"
    ];
    
    static var restaurantImages: [String:UIImage] = [
        "BBQ": UIImage(named: "BBQIcon")!,
        "Burgers": UIImage(named: "BurgersIcon")!,
        "Cafe": UIImage(named: "CafeIcon")!,
        "Chinese": UIImage(named: "ChineseIcon")!,
        "Indian": UIImage(named: "IndianIcon")!,
        "Italian": UIImage(named: "ItalianIcon")!,
        "Mexican": UIImage(named: "MexicanIcon")!,
        "Pizza": UIImage(named: "PizzaIcon")!,
        "Salad": UIImage(named: "SaladIcon")!,
        "Sandwiches": UIImage(named: "SandwichesIcon")!,
        "Steak": UIImage(named: "Steak")!,
        "Sushi": UIImage(named: "SushiIcon")!,
        "More": UIImage(named: "MoreIcon")!,
        "Seafood": UIImage(named: "SeafoodIcon")!,
        "American": UIImage(named: "AmericanIcon")!,
        "Japanese": UIImage(named: "JapaneseIcon")!
    ];
    
}
