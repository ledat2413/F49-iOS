//
//  ScreenManager.swift
//  TTC
//
//  Created by MacBookPro on 5/20/19.
//  Copyright © 2019 Luan Tran. All rights reserved.
//
import UIKit

public class ScreenManager: NSObject {
    public static var shared = ScreenManager()
    
    class func topViewController(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(viewController: selected)
            }
        }

        
        if let nav = viewController as? UINavigationController {
            return topViewController(viewController: nav.visibleViewController)
        }


        if let presented = viewController?.presentedViewController {
            return topViewController(viewController: presented)
        }

        return viewController
    }
    
    public func showRootViewController() {
        ScreenManager.topViewController()?.navigationController?.popToRootViewController(animated: true)
    }
    
    class func showPopUpViewController(popupVC: UIViewController) {
        let vc = popupVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        ScreenManager.topViewController()?.present(vc, animated: false)
    }
    
    func showDefaultFarmSettingViewController() {
//        let vc = UIStoryboard.MainStoryboard.instantiateViewController(withIdentifier: DefaultFarmSettingViewController.identifier) as! DefaultFarmSettingViewController
////        ScreenManager.topViewController()?.present(vc, animated: true, completion: nil)
//        ScreenManager.showPopUpViewController(popupVC: vc)
    }
    
}

