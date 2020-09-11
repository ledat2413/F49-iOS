//
//  SavePass.swift
//  F49
//
//  Created by Le Dat on 9/11/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation

struct SavePass{
    static let passKey = "com.save.pass"
    private static let passDefault = UserDefaults.standard
    
    static func save(_ pass: String){
        passDefault.set(pass,
                        forKey: passKey)
    }
    
    static func getPass() -> String? {
        return passDefault.value(forKey: passKey) as? String
    }
    
    static func clearUserData(){
        passDefault.removeObject(forKey: passKey)
    }
}
