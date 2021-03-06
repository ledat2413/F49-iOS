//
//  BaseResponse.swift
//  F49
//
//  Created by Le Dat on 9/8/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//
//
import Foundation
import ObjectMapper


class BaseResponseBool: Mappable{
    dynamic var success: Bool = false
    dynamic var message: String = ""
    dynamic var msgType: Int = 0
    dynamic var data: Bool = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        msgType <- map["msgType"]
        data <- map["data"]
    }
}

class BaseResponseInt: Mappable{
    dynamic var success: Bool = false
    dynamic var message: String = ""
    dynamic var msgType: Int = 0
    dynamic var data: Int = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        msgType <- map["msgType"]
        data <- map["data"]
    }
}

class BaseResponseString: Mappable{
    dynamic var success: Bool = false
    dynamic var message: String = ""
    dynamic var msgType: Int = 0
    dynamic var data: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        msgType <- map["msgType"]
        data <- map["data"]
    }
}

class BaseResponseArray<T: Mappable>: Mappable{
    dynamic var success: Bool = false
    dynamic var message: String = ""
    dynamic var msgType: Int = 0
    dynamic var data: [T] = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        msgType <- map["msgType"]
        data <- map["data"]
    }
}

class BaseResponseObject<T: Mappable>: Mappable{
    dynamic var success: Bool = false
    dynamic var message: String = ""
    dynamic var msgType: Int = 0
    dynamic var data: T?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        msgType <- map["msgType"]
        data <- map["data"]
    }
}

class BaseResponseError {
    var mErrorType: NetworkErrorType!
    var mErrorCode: Int!
    var mErrorMessage: String!
    
    init(_ errorType: NetworkErrorType,_ errorCode: Int,_ errorMessage: String) {
        mErrorType = errorType
        mErrorCode = errorCode
        mErrorMessage = errorMessage
    }
}
