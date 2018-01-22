//
//  OnboardingPageController.swift
//  WEats
//
//  Created by Will Cohen on 12/25/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

protocol pageChangeProtocol {
    func pageChanged(_ pageNumber: Int)
}

class OnboardingPageController: UIPageViewController {

    lazy var featureList: [UIViewController] = {
        let storyboardObject = UIStoryboard(name: "Main", bundle: nil);
        let firstDisplay = storyboardObject.instantiateViewController(withIdentifier: "One") as! FirstOnboardDisplay;
        firstDisplay.delegate = self;
        let secondDisplay = storyboardObject.instantiateViewController(withIdentifier: "Two") as! SecondOnboardDisplay;
        secondDisplay.delegate = self;
        let thirdDisplay = storyboardObject.instantiateViewController(withIdentifier: "Three") as! ThirdOnboardDisplay;
        thirdDisplay.delegate = self;
        let fourthDisplay = storyboardObject.instantiateViewController(withIdentifier: "Four") as! FourthOnboardDisplay;
        fourthDisplay.delegate = self;
        let fifthDisplay = storyboardObject.instantiateViewController(withIdentifier: "Five") as! FifthOnboardDisplay;
        fifthDisplay.delegate = self;
        return [firstDisplay, secondDisplay, thirdDisplay, fourthDisplay, fifthDisplay];
    }()
    
    var pageChange: pageChangeProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.hideKeyboardWhenTappedAround();
        self.dataSource = self;
        
        if let firstVC = featureList.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil);
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil);
    }
    
}

extension OnboardingPageController: firstDisplayProtocol, secondDisplayProtocol, thirdDisplayProtocol, fourthDisplayProtocol, fifthDisplayProtocol {
    
    func firstFeatureActivated() {
        pageChange.pageChanged(0);
    }
    
    func secondFeatureActivated() {
        pageChange.pageChanged(1);
    }
    
    func thirdFeatureActivated() {
        pageChange.pageChanged(2);
    }
    
    func fourthFeatureActivated() {
        pageChange.pageChanged(3);
    }
    
    func fifthFeatureActivated() {
        pageChange.pageChanged(4);
    }
    
}

extension OnboardingPageController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if (viewController == featureList[0]) {
            return nil
        } else if (viewController == featureList[1]) {
            return featureList[0];
        } else if (viewController == featureList[2]) {
            return featureList[1];
        } else if (viewController == featureList[3]) {
            return featureList[2];
        } else if (viewController == featureList[4]) {
            return featureList[3];
        } else if (viewController == featureList[5]) {
            return featureList[4];
        } else {
            return nil;
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if (viewController == featureList[0]) {
            return featureList[1]
        } else if (viewController == featureList[1]) {
            return featureList[2]
        } else if (viewController == featureList[2]) {
            return featureList[3];
        } else if (viewController == featureList[3]) {
            return featureList[4];
        } else {
            return nil;
        }
    }
    
}
