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
    
    static func loginErrors(error: Error, controller: UIViewController) {
        switch (error.localizedDescription) {
        case "The email address is badly formatted.":
            let invalidEmailAlert = UIAlertController(title: NSLocalizedString("Invalid Email", comment: "Invalid Email"), message:
                NSLocalizedString("It seems like you have put in an invalid email.", comment: "It seems like you have put in an invalid email."), preferredStyle: UIAlertControllerStyle.alert)
            invalidEmailAlert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Okay"), style: UIAlertActionStyle.default,handler: nil))
            controller.present(invalidEmailAlert, animated: true, completion: nil)
            break;
        case "The password is invalid or the user does not have a password.":
            let wrongPasswordAlert = UIAlertController(title: NSLocalizedString("Wrong Password", comment: "Wrong Password"), message:
                NSLocalizedString("It seems like you have entered the wrong password.", comment: "It seems like you have entered the wrong password."), preferredStyle: UIAlertControllerStyle.alert)
            wrongPasswordAlert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Okay"), style: UIAlertActionStyle.default,handler: nil))
            controller.present(wrongPasswordAlert, animated: true, completion: nil)
            break;
        case "There is no user record corresponding to this identifier. The user may have been deleted.":
            let wrongPasswordAlert = UIAlertController(title: NSLocalizedString("No Account Found", comment: "No Account Found"), message:
                NSLocalizedString("We couldn't find an account that corresponds to that email. Do you want to create an account?", comment: "We couldn't find an account that corresponds to that email. Do you want to create an account?"), preferredStyle: UIAlertControllerStyle.alert)
            wrongPasswordAlert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Okay"), style: UIAlertActionStyle.default,handler: nil))
            wrongPasswordAlert.addAction(UIAlertAction(title: NSLocalizedString("Create Account", comment: "Create Account"), style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                controller.performSegue(withIdentifier: "createAccountSegue", sender: nil)
            }))
            controller.present(wrongPasswordAlert, animated: true, completion: nil)
            break;
        default:
            let loginFailedAlert = UIAlertController(title: NSLocalizedString("Error Logging In", comment: "Error Logging In"), message:
                "\(NSLocalizedString("There was an error logging you in. Please try again soon.", comment: "There was an error logging you in. Please try again soon.")) \n\nError: \(error.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
            loginFailedAlert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Okay"), style: UIAlertActionStyle.default,handler: nil))
            controller.present(loginFailedAlert, animated: true, completion: nil)
            break;
        }
    }
    
    static func signUpErrors(error: Error, controller: UIViewController) {
        switch(error.localizedDescription) {
        case "The email address is badly formatted.":
            let invalidEmail = UIAlertController(title: NSLocalizedString("Email is not properly formatted.", comment: "Email is not properly formatted."), message:
                NSLocalizedString("Please enter a valid email to sign up with.", comment: "Please enter a valid email to sign up with."), preferredStyle: UIAlertControllerStyle.alert)
            invalidEmail.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(invalidEmail, animated: true, completion: nil)
            break;
        default:
            let generalErrorAlert = UIAlertController(title: NSLocalizedString("We are having trouble signing you up.", comment: "We are having trouble signing you up."), message:
                "\(NSLocalizedString("We are having trouble signing you up, please try again soon.", comment: "We are having trouble signing you up, please try again soon.")) \n\nError: \(error.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
            generalErrorAlert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Okay"), style: UIAlertActionStyle.default,handler: nil))
            controller.present(generalErrorAlert, animated: true, completion: nil)
            break;
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
    
    static func getFavorites(UID: String, completionHandler: @escaping (_ favorites: [FavoriteRestaurant]) -> Void) {
        let favoriteReference = Database.database().reference().child("Favorites").child(UID);
        var userFavorites = [FavoriteRestaurant]();
        favoriteReference.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for (snap) in snapshot {
                    if let postDict = snap.value as? Dictionary<String,AnyObject> {
                        let favRestaurant = FavoriteRestaurant(postData: postDict);
                        userFavorites.append(favRestaurant);
                    }
                }
            }
            completionHandler(userFavorites);
        }) { (error) in
            completionHandler([]);
        }
    }
    
    static func loadAppInfo(UID: String, successCompletionHandler: @escaping (_ success: Bool) -> Void) {
        getFavorites(UID: UID) { (favoriteRestaurants) in
            getAllRestaurants(completionHandler: { (allRestaurants) in
                WEUser.sharedInstance.allRestaurants = allRestaurants;
                WEUser.sharedInstance.favoriteRestaurants = favoriteRestaurants;
                successCompletionHandler(true);
            })
        }
    }
    
    static func signUp(controller: UIViewController, userEmail: String, userPassword: String, completionHandler: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (user, error) in
            if (error != nil) {
                self.signUpErrors(error: error!, controller: controller);
                completionHandler(false);
                return
            } else {
                if let user = user {
                    WEUser.sharedInstance.uid = user.uid;
                    AuthenticationService.loadAppInfo(UID: user.uid, successCompletionHandler: { (success) in
                        if (success) {
                            completionHandler(true);
                        }
                    })
                }
            }
            
        }
    }
    
    static func logIn(controller: UIViewController, userEmail: String, userPassword: String, completionHandler: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn( withEmail: userEmail, password: userPassword, completion: { (user, error) in
            if error == nil {
                if let user = user {
                    WEUser.sharedInstance.uid = user.uid;
                    loadAppInfo(UID: user.uid, successCompletionHandler: { (success) in
                        completionHandler(true);
                    })
                    //KeychainWrapper.standard.set((user?.uid)!, forKey: "uid")
                }
            } else {
                if let error = error {
                    self.loginErrors(error: error, controller: controller);
                    completionHandler(false)
                }
            }
        })
    }
    
}
