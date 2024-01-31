//
//  MapVC.swift
//  Runner
//
//  Created by Vincenzo Calia on 31/01/24.
//


import Foundation
import MapKit
import CoreLocation



///// MKMAPVIEW WORKS WITH UIBUTTON!!
class MapVC: MKMapView, UIGestureRecognizerDelegate {
   weak var mapContainerView: UIView?
//    weak var channel: FlutterMethodChannel?
   var isClicked: Bool = false;
   let locationButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
   
   override func layoutSubviews() {
       let buttonContainer = UIView()
       buttonContainer.frame = CGRect(x: self.frame.width / 2 - 80, y: 210.0, width: 160.0, height: 40.0)
           buttonContainer.layer.cornerRadius = 8
           buttonContainer.backgroundColor = .white
       locationButton.frame = CGRect(x:0, y: 0, width: 160, height: 40)
       locationButton.setTitle("click", for: UIControl.State.normal)
       locationButton.setTitleColor(UIColor.systemBlue, for: .normal)
       locationButton.addTarget(self, action: #selector(changeLocation), for:.touchUpInside)
       buttonContainer.addSubview(locationButton)
       self.addSubview(buttonContainer)
   }
   
   

   
   @objc func changeLocation() {
       if(!isClicked) {
           locationButton.setTitle("clicked", for: UIControl.State.normal)
       } else {
           locationButton.setTitle("click", for: UIControl.State.normal)
       }
       isClicked = !isClicked
   }

}