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
  
  
  //focus location
  func focusLocation(location:CLLocation = CLLocation(latitude: 40.444176, longitude: -79.945551)){
    searchTxt = ""

    let lat = location.coordinate.latitude
    let long = location.coordinate.longitude

    coordinateRegion = MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: lat, longitude: long),
      span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
  }
  
  
}
