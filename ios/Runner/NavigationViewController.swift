import Foundation
import UIKit
class NavigationVC: UIViewController {
    public var nativeViewerPlatformCahannel: FlutterMethodChannel?

    override func viewDidLoad() {
        nativeViewerPlatformCahannel = FlutterMethodChannel(name: "native_viewer_platform_channel",binaryMessenger: controller.binaryMessenger);
    }



    public func natvigateTo (params: [String: AnyObject]) {
        let params = [
            "screen": "viewController2",
            "param 1": "close native",
            "param 2": "goto VC1"
         ] as [String: AnyObject]
        nativeViewerPlatformCahannel.invokeMethod("switch_to_screen", arguments: params);
    }
}