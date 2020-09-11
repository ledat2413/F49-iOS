//
//  UserDefault.swift
//  F49
//
//  Created by Le Dat on 9/8/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation

struct UserToken{
    static let accessTokenKey = "accessTokenKey"
    static let userSessionKey = "com.save.usersession"
    private static let userDefault = UserDefaults.standard
    
    static func save(_ access_token: String){
        userDefault.set(access_token,
                        forKey: userSessionKey)
    }
    
    static func getAccessToken() -> String? {
        return userDefault.value(forKey: userSessionKey) as? String
    }
    
    static func clearUserData(){
           userDefault.removeObject(forKey: userSessionKey)
       }
}
