//
//  FDFeedEntity.swift
//  testTableViewHeightCache
//
//  Created by apple on 17/4/27.
//  Copyright © 2017年 XGHL. All rights reserved.
//

import UIKit

class FDFeedEntity: NSObject {
    
    var identifier:String?
    var title:String?
    var content:String?
    var username:String?
    var time:String?
    var imageName:String?
    static var counter = -1
    init(dictionary:Dictionary<String, String>){
        super.init()
        identifier = uniqueIdentifier()
        title = dictionary["title"]
        content = dictionary["content"]
        username = dictionary["username"]
        time = dictionary["time"]
        imageName = dictionary["imageName"]
    }
    
    func uniqueIdentifier()->String{
        FDFeedEntity.counter += 1
        return String.init(format: "unique-id-%d", FDFeedEntity.counter)
    }
}
