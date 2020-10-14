//
//  Camera.swift
//  F49
//
//  Created by Le Dat on 10/12/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import ObjectMapper


class Camera: Mappable {
    
    var imgStr: String = ""
    var soHopDong: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        imgStr <- map["imgStr"]
        soHopDong <- map["soHopDong"]
    }
}
