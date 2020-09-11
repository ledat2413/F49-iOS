//
//  SaveEmailPass.swift
//  F49
//
//  Created by Le Dat on 9/11/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation

struct SaveEmail{
    static let emailKey = "com.save.email"
    private static let emailDefault = UserDefaults.standard
    
    static func save(_ email: String){
        emailDefault.set(email,
                         forKey: emailKey)
    }
    
    static func getEmail() -> String? {
        return emailDefault.value(forKey: emailKey) as? String
    }
    
    static func clearUserData(){
        emailDefault.removeObject(forKey: emailKey)
    }
}
