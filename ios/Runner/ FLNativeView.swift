//
//   FLNativeView.swift
//  Runner
//
//  Created by Vincenzo Calia on 21/12/23.
//

import Flutter
import UIKit


// MARK: Fixed vc as per Flutter docs
//class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
//    private var messenger: FlutterBinaryMessenger
//    
//    init(messenger: FlutterBinaryMessenger) {
//        self.messenger = messenger
//        super.init()
//    }
//
//    func create(
//        withFrame frame: CGRect,
//        viewIdentifier viewId: Int64,
//        arguments args: Any?
//    ) -> FlutterPlatformView {
//        return FLNativeView(
//            frame: frame,
//            viewIdentifier: viewId,
//            arguments: args,
//            binaryMessenger: messenger)
//    }
//
//    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
//          return FlutterStandardMessageCodec.sharedInstance()
//    }
//}
//
//class FLNativeView: NSObject, FlutterPlatformView {
//    private var _view: UIView
//    
//
//    init(
//        frame: CGRect,
//        viewIdentifier viewId: Int64,
//        arguments args: Any?,
//        binaryMessenger messenger: FlutterBinaryMessenger?
//    ) {
//        let vc = ViewController();
//        var screen: String
//        if let params = args as? [String:AnyObject] {
//            vc.buttonTitleA = params["param 1"] as! String;
//            vc.buttonTitleB = params["param 2"] as! String;
//        }
//        _view = vc.view
////        _view = UIView()
//        super.init()
//        
//        
//        // iOS views can be created here
////        createNativeView(view: _view, vc: screen)
////        _view.addSubview(vc.view)// vc.view
//    }
//
//    func view() -> UIView {
//        return _view
//    }
//
//    func createNativeView(view _view: UIView){
//        _view.backgroundColor = UIColor.blue
//        let nativeLabel = UILabel()
//        nativeLabel.text = "Native text from iOS"
//        nativeLabel.textColor = UIColor.white
//        nativeLabel.textAlignment = .center
//        nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
//        _view.addSubview(nativeLabel)
//    }
//    var ViewControllerToPresent : [String : UIViewController] = [
//        "ViewController" : ViewController(),
//        "ViewController2": ViewController2()
//    ]
//}



class DynamicNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        print("DynamicNativeViewFactory init")
        return DynamicNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

class DynamicNativeView: NSObject, UIGestureRecognizerDelegate, FlutterPlatformView {
    private var _view: UIView = UIView();
    

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
         print("DynamicNativeView init")
        //MARK: crate a switch to choose the vc to be shown
        if let params = args as? [String:AnyObject] {
            let screen: String = params["screen"] as! String;
            
            if let vc = ViewControllerGetter(rawValue: screen)?.getViewController(with: params) {
//                vc.view.isUserInteractionEnabled = true;
//                _view = vc.view;
//                // _view.addSubview(vc.view);
//                _view.isOpaque = false
//                _view.isUserInteractionEnabled = true;

                 _view = vc.view;

                
            }
//            _view = vc!.view;
        }
        super.init()
        
    }

    func view() -> UIView {
        return _view
    }
}


// MARK: Dedicated view per View controller
//class DedicatedNativeViewFactory: NSObject, FlutterPlatformViewFactory {
//    private var messenger: FlutterBinaryMessenger
//    
//    init(messenger: FlutterBinaryMessenger) {
//        self.messenger = messenger
//        super.init()
//    }
//
//    func create(
//        withFrame frame: CGRect,
//        viewIdentifier viewId: Int64,
//        arguments args: Any?
//    ) -> FlutterPlatformView {
//        guard let params = args as? [String: AnyObject] else {
//            return EmptyView(
//                frame: frame,
//                viewIdentifier: viewId,
//                arguments: args,
//                binaryMessenger: messenger)};
//
//        guard let screen = params["screen"] as? String else {
//            return EmptyView(
//                frame: frame,
//                viewIdentifier: viewId,
//                arguments: args,
//                binaryMessenger: messenger)};
//
//        switch screen {
//        case "ViewController":
//            return VCNativeView(
//                frame: frame,
//                viewIdentifier: viewId,
//                arguments: args,
//                binaryMessenger: messenger)
//        case "ViewController2":
//            return VC2NativeView(
//                frame: frame,
//                viewIdentifier: viewId,
//                arguments: args,
//                binaryMessenger: messenger)
//        default:
//            return EmptyView(
//                frame: frame,
//                viewIdentifier: viewId,
//                arguments: args,
//                binaryMessenger: messenger)
//
//        }
//    }
//
//    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
//          return FlutterStandardMessageCodec.sharedInstance()
//    }
//}
//
//
//class EmptyView: NSObject, FlutterPlatformView {
//    private var _view: UIView
//    
//
//    init(
//        frame: CGRect,
//        viewIdentifier viewId: Int64,
//        arguments args: Any?,
//        binaryMessenger messenger: FlutterBinaryMessenger?
//    ) {
//        _view = UIView()
//        super.init()
//        
//    }
//
//    func view() -> UIView {
//        return _view
//    }
//}
//
//class VCNativeView: NSObject, FlutterPlatformView {
//    private var _view: UIView
//    
//
//    init(
//        frame: CGRect,
//        viewIdentifier viewId: Int64,
//        arguments args: Any?,
//        binaryMessenger messenger: FlutterBinaryMessenger?
//    ) {
//        var screen: String
//        if let params = args as? [String:AnyObject] {
//            ViewControllerToPresent.viewController.buttonTitleA = params["param 1"] as! String;
//            ViewControllerToPresent.viewController.buttonTitleB = params["param 2"] as! String;
//        }
//            _view = ViewControllerToPresent.viewController.view
//        super.init()
//    }
//
//    func view() -> UIView {
//        return _view
//    }
//
//}
//
//class VC2NativeView: NSObject, FlutterPlatformView {
//    private var _view: UIView
//    init(
//        frame: CGRect,
//        viewIdentifier viewId: Int64,
//        arguments args: Any?,
//        binaryMessenger messenger: FlutterBinaryMessenger?
//    ) {
//        //MARK: crate a switch to choose the vc to be shown
//        let vc = ViewController2();
//        var screen: String
//        if let params = args as? [String:AnyObject] {
//            vc.buttonTitleA = params["param 1"] as! String;
//            vc.buttonTitleB = params["param 2"] as! String;
//        }
//        _view = vc.view
//        super.init()
//    }
//
//    func view() -> UIView {
//        return _view
//    }
//
//}






