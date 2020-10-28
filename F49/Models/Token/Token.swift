//
//  Token.swift
//  F49
//
//  Created by Le Dat on 9/8/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Token: Object, Mappable{
    
    @objc dynamic var access_token: String = ""
    @objc dynamic var token_type: String = ""
    @objc dynamic var expires_in: Int = 0
    @objc dynamic var isFullControll: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var pageSize: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        access_token <- map["access_token"]
        token_type <- map["token_type"]
        expires_in <- map["expires_in"]
        isFullControll <- map["isFullControll"]
        email <- map["email"]
        id <- map["id"]
        pageSize <- map["pageSize"]
        
    }

}

