//
//  UserDefault.swift
//  F49
//
//  Created by Le Dat on 9/8/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation

enum UserKey: String{
    case Token = "token"
    case Email = "email"
    case Password = "password"
    case AutoLogin = "autologin"
    case BoLocTrangThai = "trangthai"
    case BoLocTextField = "textfield"
}

struct UserHelper{
    
    private static let userDefault = UserDefaults.standard
    
    static func saveUserData(_ valueData: Any?, key: UserKey){
        userDefault.set(valueData,
                        forKey: key.rawValue)
        userDefault.synchronize()
    }
    
    static func getUserData(key: UserKey) -> String? {
        return userDefault.value(forKey: key.rawValue) as? String
    }
    
    static func getAutoLogin() -> Bool {
        return userDefault.value(forKey: UserKey.AutoLogin.rawValue) as? Bool ?? false
    }
    
    static func clearUserData(key: UserKey){
        userDefault.removeObject(forKey: key.rawValue)
    }
}
