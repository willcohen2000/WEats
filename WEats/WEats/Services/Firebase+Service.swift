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
            completionHandler(pulledCategories)
        }) { (error) in
            completionHandler(nil)
        }
    }
    
}
