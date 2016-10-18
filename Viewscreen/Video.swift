//
//  Video.swift
//  Viewscreen
//
//  Created by Ugowe on 10/17/16.
//  Copyright © 2016 Ugowe. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImage: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
    
}

class Channel: NSObject {
    
    var name: String?
    var profileImageName: String?
}
