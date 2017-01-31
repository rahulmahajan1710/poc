//
//  MVMDelegate.swift
//  POCBook
//
//  Created by rahul mahajan on 30/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit


class MVMDelegate : PBPOCDelegate {
    required init() {
        
    }
    
    func pocRootViewController() -> UIViewController {
        return PBUtility.viewController(VCIdentifier: nil, SBIdentifier: MVMConstants.kStoryboardName)
    }
    
}
