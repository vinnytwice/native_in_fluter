//
//  ViewControllerGetter.swift
//  Runner
//
//  Created by Vincenzo Calia on 28/12/23.
//

import Foundation

enum ViewControllerGetter: String {
    case viewController
    case viewController2
    
    func getViewController (with params: [String: AnyObject]?) -> UIViewController? {


        switch self {
        case .viewController:
            if params != nil {
                let vc = ViewController();
                vc.buttonTitleA = params!["param 1"] as? String;
                vc.buttonTitleB = params!["param 2"] as? String;
                return vc
            }
        case .viewController2:
            if params != nil {

                let vc = ViewController2();
                vc.buttonTitleA = params!["param 1"] as? String;
                vc.buttonTitleB = params!["param 2"] as? String;
                return vc
            }

        }
        return nil
    }
}

