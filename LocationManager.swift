//
//  LocationManager.swift
//  Abhay Shankar
//
//  Created by Abhay Shankar on 19/07/18.
//  Copyright © 2018 Abhay Shankar. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {

    var locationManager : CLLocationManager?
    
    /// Get location of user
    ///
    /// - Returns: Tuple of string having Latitude and Logitude
    func getLocation() -> (lat:String,long:String)? {
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus(){
            case .restricted, .denied:
                print("No access")
                return nil
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                if let location = locationManager?.location{
                    return (String(format:"%f", location.coordinate.latitude),String(format:"%f", location.coordinate.longitude))
                }
                else{
                    return nil
                }
                
            case .notDetermined:
                print("not determined")
                return nil
            }
        }
        else
        {
            return nil
        }
    }
    
    /// Initialise Location manager
    func initialiseLocation() {
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus(){
            case .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                startLocation()
            case .notDetermined:
                print("not determined")
                startLocation()
            }
        }
    }
    
    /// Start monitoring location
    func startLocation() {
        if locationManager == nil{
            locationManager = CLLocationManager.init()
        }
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    /// Stop monitoring location
    func stopLocation() {
        locationManager?.stopUpdatingLocation()
    }
    
   
}

extension LocationManager:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
        case .restricted, .denied:
            print("No access")

        case .authorizedAlways, .authorizedWhenInUse:
            print("Access")
            locationManager?.startUpdatingLocation()
        case .notDetermined:
            print("not determined")
            locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location failed")

    }
}
