//
//  MVMFacialExpressions.swift
//  POCBook
//
//  Created by rahul mahajan on 30/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import Foundation


struct MVMFacialExpressions {
    
    enum Eyes : Int {
        case Open
        case Closed
        case Squinting
    }
    
    enum EyeBrows : Int {
        case Relaxed
        case Normal
        case Furrowed
        
        func moreRelaxedBrow() -> EyeBrows {
            return EyeBrows(rawValue : rawValue - 1) ?? .Relaxed
        }
        
        func moreFurrowedBrow() -> EyeBrows {
            return EyeBrows(rawValue : rawValue + 1) ?? .Furrowed
        }
    }
    
    enum Mouth : Int {
        case Frown
        case Smirk
        case Neutral
        case Grin
        case Smile
        
        func sadderMouth() -> Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .Frown
        }
        
        func happierMouth() -> Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .Smile
        }
    }
    
    var eyes : Eyes
    var eyeBrows : EyeBrows
    var mouth : Mouth
    
    
    
}
