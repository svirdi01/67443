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
  
  //OTHER SHIT
  @Published var region : MKCoordinateRegion!
  
  
  
  
  
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
}
