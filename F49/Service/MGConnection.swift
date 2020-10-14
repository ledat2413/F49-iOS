//
//  MGConnection.swift
//  F49
//
//  Created by Le Dat on 9/8/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RealmSwift


class MGConnection {
    
    static func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }

    //MARK: --Request Boolean
       
       static func requestBoolean(_ apiRouter: APIRouter, returnType: Bool?, completion: @escaping (_ result: Bool?, _ error: BaseResponseError?) -> Void) {
              if !isConnectedToInternet() { return }
              
              Alamofire.request(apiRouter).responseObject { (response: DataResponse<BaseResponseBool>) in
                  switch response.result {
                  case .success:
                      if response.response?.statusCode == 200 {
                          completion(response.result.value?.data, nil)
                          print(response.request ?? "")
                      } else {
                          let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, (response.response?.statusCode)!, "Request is error!")
                          completion(nil, err)
                      }
                      break
                      
                  case .failure(let error):
                   if response.response?.statusCode != 200 {
                       completion(response.result.value?.data, nil)
                       print(response)
                   }
                     else if error is AFError {
                          let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, error._code, "Request is error!")
                          completion(nil, err)
                      }
                      
                      break
                  }
              }
          }
    //MARK: --Request String
    
    static func requestString(_ apiRouter: APIRouter, returnType: String?, completion: @escaping (_ result: String?, _ error: BaseResponseError?) -> Void) {
           if !isConnectedToInternet() { return }
           
           Alamofire.request(apiRouter).responseObject { (response: DataResponse<BaseResponseString>) in
               switch response.result {
               case .success:
                   if response.response?.statusCode == 200 {
                       completion(response.result.value?.data, nil)
                       print(response.request ?? "")
                   } else {
                       let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, (response.response?.statusCode)!, "Request is error!")
                       completion(nil, err)
                   }
                   break
                   
               case .failure(let error):
                if response.response?.statusCode != 200 {
                    completion(response.result.value?.data, nil)
                    print(response.request ?? "")
                }
                  else if error is AFError {
                       let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, error._code, "Request is error!")
                       completion(nil, err)
                   }
                   
                   break
               }
           }
       }
    
    static func requestInt(_ apiRouter: APIRouter, returnType: Int?, completion: @escaping (_ result: Int?, _ error: BaseResponseError?) -> Void) {
        if !isConnectedToInternet() { return }
        
        Alamofire.request(apiRouter).responseObject { (response: DataResponse<BaseResponseInt>) in
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    completion(response.result.value?.data, nil)
                    print(response.request ?? "")
                } else {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, (response.response?.statusCode)!, "Request is error!")
                    completion(nil, err)
                }
                break
                
            case .failure(let error):
                if error is AFError {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, error._code, "Request is error!")
                    completion(nil, err)
                }
                
                break
            }
        }
        
    }
    
    
    //MARK: --Request Token
    static func requestToken<T: Mappable>(_ apiRouter: APIRouter,_ returnType: T.Type, completion: @escaping (_ result: T?, _ error: BaseResponseError?) -> Void) {
        if !isConnectedToInternet() {
            return
        }
        Alamofire.request(apiRouter).responseObject{(response: DataResponse<T>) in
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    completion(response.result.value, nil)
                } else {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, (response.response?.statusCode)!, "Request is error!")
                    completion(nil, err)
                }
                break
                
            case .failure(let error):
                if error is AFError {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, error._code, "Request is error!")
                    completion(nil, err)
                } else if error is AFError{
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.EMAIL_ISVALID, error._code, "Email is valid!")
                }
                
                break
            }
        }
    }
    
    //MARK : -- Request Array
    static func requestArray<T: Mappable>(_ apiRouter: APIRouter,_ returnType: T.Type, completion: @escaping (_ result: [T]?, _ error: BaseResponseError?) -> Void) {
        if !isConnectedToInternet() {
            return
        }
        
        Alamofire.request(apiRouter).responseObject {(response: DataResponse<BaseResponseArray<T>>) in
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    completion(response.result.value?.data, nil)
                    print(response.request ?? "")
                } else {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, (response.response?.statusCode)!, "Request is error!")
                    completion(nil, err)
                }
                break
                
            case .failure(let error):
                if error is AFError {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, error._code, "Request is error!")
                    completion(nil, err)
                }
                
                break
            }
        }
    }
    
    // MARK : -- Request Object
    static func requestObject<T: Mappable>(_ apiRouter: APIRouter,_ returnType: T.Type, completion: @escaping (_ result: T?, _ error: BaseResponseError?) -> Void) {
        if !isConnectedToInternet(){
            return
        }
        Alamofire.request(apiRouter).responseObject{(response: DataResponse<BaseResponseObject<T>>) in
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    completion(response.result.value?.data, nil)
                } else {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, (response.response?.statusCode)!, "Request is error!")
                    completion(nil, err)
                }
                break
            case .failure(let error):
                if error is AFError {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, error._code, "Request is error!")
                    completion(nil, err)
                }
                
                break
            }
        }
        
    }
}




