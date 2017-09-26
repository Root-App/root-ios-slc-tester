//
//  AppDelegate.swift
//  SlcTester
//
//  Created by Jimmy Devine on 9/26/17.
//  Copyright © 2017 Root. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    var locationManager: CLLocationManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        CachedLog.log("App started")
        
        locationManager = CLLocationManager()
        locationManager.delegate = self

        locationManager.requestAlwaysAuthorization()

        return true
    }
}

extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach { (location) -> Void in
            CachedLog.log(String(format: "SLC, lat: %f, long: %f, timestamp: %@", location.coordinate.latitude, location.coordinate.longitude, location.timestamp.debugDescription))
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            CachedLog.log("Permissions authorized")
            locationManager.startMonitoringSignificantLocationChanges()
        } else {
            CachedLog.log("Permissions failure!")
        }

    }
}

