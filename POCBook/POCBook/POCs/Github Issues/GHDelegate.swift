//
//  GHDelegate.swift
//  POCBook
//
//  Created by rahul mahajan on 17/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

let kGHStoryboardName = "GITHUB_ISSUES"

class GHDelegate: PBPOCDelegate {
    
    required init() {
        
    }
    
    func pocRootViewController() -> UIViewController {
        let storybaord = UIStoryboard(name: kGHStoryboardName, bundle: Bundle.main)
        return storybaord.instantiateInitialViewController()!
    }
}
