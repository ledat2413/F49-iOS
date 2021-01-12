//
//  CamDo.swift
//  F49
//
//  Created by Le Dat on 9/18/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper


class CamDo: Mappable{
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var balance: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var active: Bool = false
    @objc dynamic var brand: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var descriptionn: String = ""

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        balance <- map["balance"]
        phone <- map["phone"]
        active <- map["active"]
        brand <- map["brand"]
        date <- map["date"]
        descriptionn <- map["description"]
        
    }
}
