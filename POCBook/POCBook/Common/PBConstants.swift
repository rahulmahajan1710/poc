//
//  PBConstants.swift
//  POCBook
//
//  Created by rahul mahajan on 23/12/16.
//  Copyright © 2016 rahul mahajan. All rights reserved.
//

import Foundation
import UIKit


struct PBConstants {
    
    struct FileNames {
        static let pocPlistFileName                 = "PBPocInfo"
    }
    
    struct KeyConstants {
        static let status                           = "STATUS"
        static let success                          =  true
        static let failure                          =  false
        static let pocListName                      = "POC_LIST"
        static let pocName                          = "POC_NAME"
        static let pocStoryboard                    = "POC_STORYBOARD"
    }
    
    struct Colors {
        static let tealColor                        = colorWith(red: 0, green: 150, blue: 136)
        
        static func colorWith(red : CGFloat , green : CGFloat , blue : CGFloat) -> UIColor {
            return colorWith(red: red, green: green, blue: blue, alpha: 0.0)
        }
        
        static func colorWith(red : CGFloat , green : CGFloat , blue : CGFloat , alpha : CGFloat) -> UIColor{
            return UIColor( red: (red/255.0), green: (green/255.0), blue: (blue/255.0), alpha: alpha)
        }
    }
    
    struct GITIssues {
        static let commentsURL                      = "comments_url"
        static let title                            = "title"
        static let body                             = "body"
        static let updatedAt                        = "updated_at"
        static let dateFormat                       = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        static let userName                         = "user"
        static let login                            = "login"
    }
}

enum HTTPMethod : String {
    case POST = "POST"
    case GET  = "GET"
}

