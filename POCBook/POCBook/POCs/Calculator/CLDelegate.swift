//
//  CLDelegate.swift
//  POCBook
//
//  Created by rahul mahajan on 27/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

class CLDelegate: PBPOCDelegate {

    required init() {
        
    }
    
    func pocRootViewController() -> UIViewController {
        return PBUtility.viewController(VCIdentifier: nil, SBIdentifier: CLViewIdentifiers.kCLMainStoryboard)
    }
}
