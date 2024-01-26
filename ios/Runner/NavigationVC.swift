//
//  NavigationVC.swift
//  Runner
//
//  Created by Vincenzo Calia on 25/01/24.
//
import Flutter
import Foundation
import UIKit
class NavigationVC: UIViewController {
    public var nativeViewerPlatformCahannel: FlutterMethodChannel?

    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let controller = appDelegate.window?.rootViewController as! FlutterViewController;
        nativeViewerPlatformCahannel = FlutterMethodChannel(name: "native_viewer_platform_channel",binaryMessenger: controller.binaryMessenger);
    }



    public func natvigateTo (params: [String: AnyObject]) {
        let params = [
            "screen": "viewController2",
            "param 1": "close native",
            "param 2": "goto VC1"
         ] as [String: AnyObject]
        nativeViewerPlatformCahannel?.invokeMethod("switch_to_screen", arguments: params);
    }
}
