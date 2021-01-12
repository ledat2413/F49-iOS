//
//  ListRutLai.swift
//  F49
//
//  Created by Le Dat on 9/29/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper


class ListRutLai: Mappable{
    
    @objc dynamic var text: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        text <- map["text"]
    }
    
    
}
