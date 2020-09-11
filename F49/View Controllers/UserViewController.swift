//
//  UserViewController.swift
//  F49
//
//  Created by Le Dat on 9/9/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserProfile()
    }
    
    private func loadUserProfile(){
        MGConnection.requestProfile(APIRouter.GetUserProfile, UserProfile.self) { (result, error) in
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorType))")
                return
            }
            if let result = result {
             print(result)
            }
        }
    }
    
}
