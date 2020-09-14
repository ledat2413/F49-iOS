//
//  SaveIdCuaHang.swift
//  F49
//
//  Created by Le Dat on 9/14/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation


struct SaveIdCuaHang{
    static let idKey = "com.save.id"
    private static let idDefault = UserDefaults.standard
    
    static func save(_ id: Int){
        idDefault.set(id,
                      forKey: idKey)
    }
    
    static func getId() -> Int? {
        return idDefault.value(forKey: idKey) as? Int
    }
    
    static func clearUserData(){
        idDefault.removeObject(forKey: idKey)
    }
}
