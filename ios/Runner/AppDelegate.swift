import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
    // define method channels
    // var methodChannel: FlutterMethodChannel?
    // var nativeViewerPlatformCahannel: FlutterMethodChannel?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      // instantiate the root vc as a flutter vc
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
      // init method channels
      
      // // native method channel
      // let nativeViewerPlatformCahannel = FlutterMethodChannel(name: "native_viewer_platform_channel",binaryMessenger: controller.binaryMessenger);
      //   let params = [
      //       "screen": "viewController2",
      //       "param 1": "close native",
      //       "param 2": "goto VC1"
      //    ] as [String: AnyObject]
      
      // // methgodes invoked directly won't get triggered, the need to be invoked from a method.
      //   nativeViewerPlatformCahannel.invokeMethod("switch_to_screen", arguments: params);

      
      
      
      
      
      
      // test method channel
      let methodChannel = FlutterMethodChannel(name: "test_platform_channel",binaryMessenger: controller.binaryMessenger);
      // method invocation here never gets called
      methodChannel.invokeMethod("swift_to_flutter", arguments: ["AppDelegate method channel instantiated"]); 
      // set method call handler
      methodChannel.setMethodCallHandler({ //[weak self]
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          // gets called at every method invocation received
          methodChannel.invokeMethod("swift_to_flutter", arguments: ["AppDelegate method call handler instantiated"]); 
        //   let params = [
        //     "screen": "viewController2",
        //     "param 1": "close native",
        //     "param 2": "goto VC1"
        //  ] as [String: AnyObject]
        // nativeViewerPlatformCahannel.invokeMethod("switch_to_screen", arguments: params);



          switch(call.method) {
          case "test":
              methodChannel.invokeMethod("swift_to_flutter", arguments: ["AppDelegate method call handler: received test method call"]);
          default:
              print("")
          }
      });


      GeneratedPluginRegistrant.register(with: self);
      // MARK: NATIVE in Flutter setup

      weak var registrar = self.registrar(forPlugin: "plugin-name");
      let factory = DynamicNativeViewFactory(messenger: registrar!.messenger())
      self.registrar(forPlugin: "<plugin-name>")!.register(
          factory,
          withId: "<platform-view-type>")
          
      
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
