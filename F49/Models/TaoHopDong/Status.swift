//
//  Status.swift
//  F49
//
//  Created by Le Dat on 9/18/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper


class Status: Mappable{
    
    @objc dynamic var id: String = ""
    @objc dynamic var value: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        value <- map["value"]
    }
}

class StatusHopDong: Mappable{
    
    @objc dynamic var id: Int = 0
    @objc dynamic var value: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        value <- map["value"]
    }
}
