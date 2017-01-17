//
//  PBUtility.swift
//  POCBook
//
//  Created by rahul mahajan on 05/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

class PBUtility: NSObject {
    
    static func viewController(VCIdentifier: String? , SBIdentifier : String) -> UIViewController {
        let storyboard =  UIStoryboard(name: SBIdentifier, bundle: Bundle.main)
        if VCIdentifier == nil {
            return storyboard.instantiateInitialViewController()!
        }
        return storyboard.instantiateViewController(withIdentifier: VCIdentifier!)
    }
    
    
    
}
