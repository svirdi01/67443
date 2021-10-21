//
//  MapView.swift
//  443App
//
//  Created by Simran Virdi on 10/20/21.
//

//
//  MapView.swift
//  app
//
//  Created by Neha Joshi on 9/28/21.
//
import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
  let viewController: ViewController
  
 
  
  func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
    let user = viewController.currLocation
    user.loadLocation()
    
    uiView.showsUserLocation = true
    
    
    let coordinate = CLLocationCoordinate2D(latitude: viewController.currLocation.latitude, longitude: viewController.currLocation.longitude)
    
    
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    uiView.setRegion(region, animated: true)
  }

  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView(frame: .zero)
    let user = viewController.currLocation
    user.loadLocation()
    let pinArr: [[CLLocationDegrees]] = [[40.442609,-79.946401], [40.445609,-79.945401], [40.441609,-79.945401]]
    let labelArr: [String] = ["Met first significant other", "Almost lost my life to a SPIN scooter","pulled first all nighter"]
  
    for n in 0...2{
      let droppedPin = MKPointAnnotation()
      droppedPin.coordinate = CLLocationCoordinate2D(
        latitude: pinArr[n][0] ,
        longitude: pinArr[n][1]
      )
      droppedPin.title = labelArr[n]
      mapView.addAnnotation(droppedPin)
      
    }
    
    
    return mapView
  }
   
}

struct MapView_Previews : PreviewProvider {
    static var previews: some View {
      MapView(viewController: ViewController())
    }
}
