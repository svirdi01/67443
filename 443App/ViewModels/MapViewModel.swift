//
//  MapViewModel.swift
//  443App
//
//  Created by Neha Joshi on 11/30/21.
//

import Foundation
import SwiftUI
import MapKit

class MapViewModel: ObservableObject{
  
  //really trying something here
  @State var trackingMode: MapUserTrackingMode = .follow
  @Published var coordinateRegion = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 40.444176, longitude: -79.945551),
    span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
  
 // @Published var mapView
  
  
  
  //@Published var mapView = self.mapView
  
  //OTHER SHIT
//  @Published var region : MKCoordinateRegion! = MKCoordinateRegion(
//    center: CLLocationCoordinate2D(latitude: 40.444176, longitude: -79.945551),
//    span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
  
  
  
  
  
  // SEARCH SHIT
  @Published var searchTxt = ""
  
  @Published var places: [Place] = []
  
  func searchQuery(){
    places.removeAll()
    let request=MKLocalSearch.Request()
    request.naturalLanguageQuery = searchTxt
    
    //Fetch
    MKLocalSearch(request:request).start { (response, _) in
      guard let result = response else{return}
      
      self.places=result.mapItems.compactMap({ (item) -> Place? in
        return Place(place: item.placemark)
      })
    }
    
  }
  
  func selectPlace(place: Place){
    searchTxt = ""
    guard let coordinate = place.place.location?.coordinate else{return}
    let pointAnnotation = MKPointAnnotation()
    pointAnnotation.coordinate = coordinate
    pointAnnotation.title=place.place.name ?? "No Name"
    
    //MapView.removeAnnotations(mapView.annotations)
    //MapView.addAnnotation(pointAnnotation)
    
    
  }
  //focus location
  func focusLocation(){
    //guard let _ = region else{return}
    coordinateRegion = MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: 40.444176, longitude: -79.945551),
      span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
    //MapView.setRegion(region, animated: true)
    //MapView.setVisibleMapRect
  }
}
