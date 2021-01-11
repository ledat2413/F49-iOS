//
//  FirebaseModel.swift
//  F49
//
//  Created by Le Dat on 1/11/21.
//  Copyright © 2021 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper

class NotificationVO: Mappable {
       var title: String = ""
        var itemId: String = ""
        var screenId: String = ""
        var message: String = ""
        var id : String = ""
    
    required  init?(map: Map) {
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        itemId <- map["itemId"]
        screenId <- map["screenId"]
        message <- map["message"]
        id <- map["id"]
    }

}
