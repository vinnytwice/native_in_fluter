//
//  ViewController2.swift
//  Runner
//
//  Created by Vincenzo Calia on 27/12/23.
//

import UIKit
import Flutter

class ViewController2: UIViewController {
    var buttonTitleA: String?
    var buttonTitleB: String?
    
     override func viewDidLoad() {
         
         super.viewDidLoad()

         let buttonA = UIButton(type:UIButton.ButtonType.custom)
         buttonA.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
//         buttonA.setTitle("Flutter Screen A", for: UIControl.State.normal)
         buttonA.setTitle(buttonTitleA ?? "Flutter Screen A", for: UIControl.State.normal)
         buttonA.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
         buttonA.backgroundColor = UIColor.systemGray5
         buttonA.setTitleColor(UIColor.systemBlue, for: .normal)
         buttonA.layer.cornerRadius = 8;
         self.view.addSubview(buttonA)
        
        
         let buttonB = UIButton(type:UIButton.ButtonType.custom)
         buttonB.addTarget(self, action: #selector(flutterButtonBTapped), for: .touchUpInside)
//         buttonB.setTitle("Flutter Screen B", for: UIControl.State.normal)
         buttonB.setTitle(buttonTitleB ?? "Flutter Screen B", for: UIControl.State.normal)

         buttonB.frame = CGRect(x: 80.0, y: 260.0, width: 160.0, height: 40.0)
         buttonB.backgroundColor = UIColor.systemGray5
         buttonB.setTitleColor(UIColor.systemBlue, for: .normal)
         buttonB.layer.cornerRadius = 8;
         self.view.addSubview(buttonB);
//         
         
         
         
         
     }

    
    
   @objc func flutterButtonBTapped() {
       // Implement your native functionality here
       print("flutterButtonBTapped - perform your native action here")
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
       let controller = appDelegate.window?.rootViewController as! FlutterViewController;

       let nativeMethodChannel = FlutterMethodChannel(name: "flutter_button_b", binaryMessenger: controller.binaryMessenger);

       let params = [
        "screen": "viewController",
        "param 1": "close native",
        "param 2": "goto VC2"
       ]
       nativeMethodChannel.invokeMethod("switch_to_screen", arguments: params);

   }
    @objc func dismissViewController(vc: FlutterViewController){
         vc.dismiss(animated: true);
     }
}

