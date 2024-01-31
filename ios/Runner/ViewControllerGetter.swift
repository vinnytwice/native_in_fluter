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
    case viewController3
    case viewController4
    case viewController5
    
    func getViewController (with params: [String: AnyObject]?) -> UIView? {
        switch self {
        case .viewController:
            if params != nil {
                let vc = ViewController();
                vc.buttonTitleA = params!["param 1"] as? String;
                vc.buttonTitleB = params!["param 2"] as? String;
                
                return vc.view
            }
        case .viewController2:
            if params != nil {

                let vc = TableVC();
                return vc.view
            }

        case .viewController3:
            if params != nil {

                let vc = ScrollVC();
                return vc.view
            }
        case .viewController4:
            if params != nil {
                let vc = MapVC();
                return vc
            }
        case .viewController5:
            if params != nil {
                let vc = VCMapVC();
                return vc.view
            }
        }
        return nil
    }
}

