// Created for 443App on 11/10/21 
// Using Swift 5.0 
// Running on macOS 11.6
// Qapla'
//

import Foundation
import MapKit
import SwiftUI
import CoreLocation


class LocationDelegate: NSObject, ObservableObject, CLLocationManagerDelegate         {

   @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.442609, longitude: -79.946401), latitudinalMeters: 10000, longitudinalMeters: 10000)

   func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
       if manager.authorizationStatus == .authorizedWhenInUse {
           print("Authorized...")
           manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
           manager.startUpdatingLocation()
       } else {
           print("Not Authorized...")
           manager.requestWhenInUseAuthorization()
       }
   }

   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       print("Updated Location")
       region.center.latitude = (manager.location?.coordinate.latitude)!
       region.center.longitude = (manager.location?.coordinate.longitude)!
   }
}
