//
//  GetTab.swift
//  F49
//
//  Created by Le Dat on 9/23/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//


import Foundation
import ObjectMapper


class Tab: Mappable{
    
    var id: Int = 0
    var value: String = ""
    
    required init?(map: Map) {
    }
    
    init(id: Int, value: String) {
        self.id = id
        self.value = value
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        value <- map["value"]
    }
    
}
