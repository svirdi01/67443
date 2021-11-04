//
//  ViewController.swift
//  443App
//
//  Created by Simran Virdi on 10/20/21.
//

//
//  ViewController.swift
//  app
//
//  Created by Neha Joshi on 9/28/21.
//

import Foundation
import UIKit
import MapKit
class ViewController: UIViewController, ObservableObject
{
  let currLocation = Location()
  private var mapView: MKMapView!
  //mapView.showsUserLocation = true;
  //mapView.delegate = self
  private let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("NEHA")
    //do any additional setup here
    mapView.delegate = self
  }
  

  func generateTitle() -> String {
    let message = "Your car is currently at:\n(\(self.currLocation.latitude), \(self.currLocation.longitude))"
    return message
  }


  
}


//MKMapView Delegate Methods
extension ViewController: MKMapViewDelegate{
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation ) -> MKAnnotationView? {
      guard let annotation = annotation as? MyCustomPointAnnotation else {
        return nil
      }
    let identifier = "artwork"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
          withIdentifier: identifier) as? MKMarkerAnnotationView {
          dequeuedView.annotation = annotation
          view = dequeuedView
        } else {
          // 5
          view = MKMarkerAnnotationView(
            annotation: annotation,
            reuseIdentifier: identifier)
          view.canShowCallout = true
          view.calloutOffset = CGPoint(x: -5, y: 5)
          view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
  }

  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
      print("AJJHH")
  }
}
