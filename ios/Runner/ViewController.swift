//
//  ViewController.swift
//  UiKitFlutter
//
//  Created by vincenzo calia on 16/10/23.
//

import Flutter

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    public var buttonTitleA: String?
    public var buttonTitleB: String?
    var buttonA = UIButton(type:UIButton.ButtonType.custom)
    var buttonB = UIButton(type:UIButton.ButtonType.custom)

     override func viewDidLoad() {
         
         super.viewDidLoad()

         buttonA.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
         buttonA.setTitle(buttonTitleA ?? "Flutter Screen A", for: UIControl.State.normal)
         buttonA.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
         buttonA.backgroundColor = UIColor.systemGray5
         buttonA.setTitleColor(UIColor.systemBlue, for: .normal)
         buttonA.layer.cornerRadius = 8;
         self.view.addSubview(buttonA)

         let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(flutterButtonBTapped));

         gestureRecognizer.isEnabled = true
         
        gestureRecognizer.cancelsTouchesInView = false

         gestureRecognizer.delegate = self

         
         
        buttonB.addGestureRecognizer(gestureRecognizer);

        // buttonB.addTarget(self, action: #selector(flutterButtonBTapped), for: .touchUpInside)


         buttonB.setTitle(buttonTitleB ?? "Flutter Screen B", for: UIControl.State.normal)
         buttonB.frame = CGRect(x: 80.0, y: 260.0, width: 160.0, height: 40.0)
         buttonB.backgroundColor = UIColor.systemGray5
         buttonB.setTitleColor(UIColor.systemBlue, for: .normal)
         buttonB.layer.cornerRadius = 8;
         self.view.addSubview(buttonB);
         
         
// THE ISSUE:
// called here invokeMethod works so we are sure that the desired beahviour is correct..calling it from button doesn't.
// Native gesture detection is not recognized when native ViewController is shown in Flutter, so no interaction with native buttons is possible.

// WHAT I TRIED:
// Wrapping the UiKitVIew with a GestureDetector, so we made sure that gestures are passed down to it.
// As a test I swapped the UiKitView wit an ElevatedButton and tested that both onTap from GestureDetector 
// and onPressed from the ElevatedButton callbacks where in fact working as expected.
// I added UIGestureRecognizerDelegate and setup methods to make sure that gestures were detected by the native ViewController, but to no avail.
// 
// OUTCOME: No interaction with the native ViewController has been achieved, making the whole hosting native views in flutter a waste of time.


        // let params = [
        //         "screen": "viewController2",
        //         "param 1": "close native",
        //         "param 2": "goto VC1"
        //     ] as [String: AnyObject]
        // let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        // let controller = appDelegate.window?.rootViewController as! FlutterViewController;
        // var nativeViewerPlatformCahannel = FlutterMethodChannel(name: "native_viewer_platform_channel",binaryMessenger: controller.binaryMessenger);
        // nativeViewerPlatformCahannel.invokeMethod("switch_to_screen", arguments: params);
    }
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//     func gestureRecognizer(
//     _ gestureRecognizer: UIGestureRecognizer,
//     shouldReceive touch: UITouch
// ) -> Bool {
//     return true
// }
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive event: UIEvent
    ) -> Bool {
        return true
    }


   @objc func flutterButtonBTapped() {
    
    
       // Implement your native functionality here
       buttonA.setTitle("new value", for: UIControl.State.normal)
        let params = [
                "screen": "viewController2",
                "param 1": "close native",
                "param 2": "goto VC1"
            ] as [String: AnyObject]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let controller = appDelegate.window?.rootViewController as! FlutterViewController;
       let nativeViewerPlatformCahannel = FlutterMethodChannel(name: "native_viewer_platform_channel",binaryMessenger: controller.binaryMessenger);
        nativeViewerPlatformCahannel.invokeMethod("switch_to_screen", arguments: params);

       let buttonA = UIButton(type:UIButton.ButtonType.infoDark)
        //  buttonA.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
//         buttonA.setTitle("Flutter Screen A", for: UIControl.State.normal)
         buttonA.setTitle("added", for: UIControl.State.normal)
         buttonA.frame = CGRect(x: 80.0, y: 410.0, width: 160.0, height: 40.0)
         buttonA.backgroundColor = UIColor.systemGray5
         buttonA.setTitleColor(UIColor.systemBlue, for: .normal)
         buttonA.layer.cornerRadius = 8;
         self.view.addSubview(buttonA)
        

   }


    @objc func dismissViewController(vc: FlutterViewController){
        //  vc.dismiss(animated: true);
     }
}

