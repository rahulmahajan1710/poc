//
//  PBPoc.swift
//  POCBook
//
//  Created by rahul mahajan on 23/12/16.
//  Copyright © 2016 rahul mahajan. All rights reserved.
//

import Foundation

class PBPoc {
    let pocName           : String
    let pocDelegateClass  : String
    
    init(pocInfo : Dictionary<String,String>) {
        pocName = pocInfo[PBConstants.KeyConstants.pocName]!
        pocDelegateClass = pocInfo[PBConstants.KeyConstants.pocDelegate]!
    }
}
