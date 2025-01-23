//
//  QiblaDirectionViewController.swift
//  toufik
//
//  Created by Ratul Sharker on 6/3/21.
//

import Foundation
import CoreLocation
import UIKit

class QiblaDirectionViewController : UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var angleLabel: UILabel!
    @IBOutlet weak var simulate4thAprilSwitch: UISwitch!
    @IBOutlet weak var simulate15thAprilSwitch: UISwitch!
    
    
    let locationDelegate = LocationDelegate()
    var latestLocation: CLLocation? = nil
    var yourLocationBearing: CGFloat { return latestLocation?.bearingToLocationRadian(self.yourLocation) ?? 0 }
    var yourLocation: CLLocation {
      get { return UserDefaults.standard.currentLocation }
      set { UserDefaults.standard.currentLocation = newValue }
    }
    
    let locationManager: CLLocationManager = {
      $0.requestWhenInUseAuthorization()
      $0.desiredAccuracy = kCLLocationAccuracyBest
      $0.startUpdatingLocation()
      $0.startUpdatingHeading()
      return $0
    }(CLLocationManager())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppTopBackground()
        setupAppBottomBackground()
        setupCustomBackButton()
        setupTitle(title: "wKejv") // কিবলা
        
        setupRamadanUISwitch()
        
        locationManager.delegate = locationDelegate
        var qiblaAngle : CGFloat = 0.0
        
        locationDelegate.errorCallback = { error in
            self.angleLabel.textColor = .red
            self.angleLabel.text = error
            self.imageView.isHidden = true
            self.angleLabel.isHidden = false
            print(error)
        }
        
        locationDelegate.locationCallback = { [weak self] location in
            self?.latestLocation = location
            
            let phiK = 21.4*CGFloat.pi/180.0
            let lambdaK = 39.8*CGFloat.pi/180.0
            let phi = CGFloat(location.coordinate.latitude) * CGFloat.pi/180.0
            let lambda =  CGFloat(location.coordinate.longitude) * CGFloat.pi/180.0
            qiblaAngle = 180.0/CGFloat.pi * atan2(sin(lambdaK-lambda),cos(phi)*tan(phiK)-sin(phi)*cos(lambdaK-lambda))
            
//            self.angleLabel.textColor = .black
//            self.angleLabel.text = "\(Int(qiblaAngle.rounded()))°"
            
            
            self?.imageView.isHidden = false
            self?.angleLabel.isHidden = true
        }
        
        locationDelegate.headingCallback = { newHeading in
          
          func computeNewAngle(with newAngle: CGFloat) -> CGFloat {
            let heading = self.yourLocationBearing - newAngle.degreesToRadians
            return CGFloat(heading)
          }
          
          UIView.animate(withDuration: 0.5) {
            let angle = (CGFloat.pi/180 * -(CGFloat(newHeading) - qiblaAngle))
            self.imageView.transform = CGAffineTransform(rotationAngle: angle)
          }
        }
    }

    
    private func setupRamadanUISwitch() {
        simulate4thAprilSwitch.isOn = UserDefaults.standard.read4thAprilAsTodayAndShowRamadanUI
        simulate15thAprilSwitch.isOn = UserDefaults.standard.read15thAprilAsTodayAndShowRamadanUI
    }
    
    @IBAction
    public func switch4thAprilValueChanged(sender: UISwitch) {
        UserDefaults.standard.read4thAprilAsTodayAndShowRamadanUI = sender.isOn
        showRestartAlert()
    }
    
    @IBAction
    public func switch15thAprilValueChanged(sender: UISwitch) {
        UserDefaults.standard.read15thAprilAsTodayAndShowRamadanUI = sender.isOn
        showRestartAlert()
    }
    
    private func showRestartAlert() {
        let alert = UIAlertController(title: "Restart", message: "to see the change in action", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
