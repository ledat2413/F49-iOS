//
//  GetTab.swift
//  F49
//
//  Created by Le Dat on 9/23/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//


import Foundation
import ObjectMapper
import RealmSwift

class Tab: Mappable{
    required init?(map: Map) {
        
    }
    
    
      var id: Int = 0
      var value: String = ""
    
    
    init(id: Int, value: String) {
        self.id = id
        self.value = value
    }
    
//    required convenience init?(map: Map) {
//        self.init()
//    }
    
    
    func mapping(map: Map) {
        id <- map["id"]
        value <- map["value"]
    }
    
}
