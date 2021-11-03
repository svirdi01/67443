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
import Combine

struct MapView: UIViewRepresentable {
  @ObservedObject var viewController: ViewController
  @EnvironmentObject var viewModel: ViewModel
  

 
  
  func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
    print("UPDATING UI VIEW")
    let user = viewController.currLocation
    user.loadLocation()
    
    //uiView.showsUserLocation = true
    
    
    let coordinate = CLLocationCoordinate2D(latitude: viewController.currLocation.latitude, longitude: viewController.currLocation.longitude)
    
    
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    uiView.setRegion(region, animated: true)
    
    //need to flush all annotations at start of update UI view
    for memory in viewModel.sampleUser.allPins{
      print("MAKING PINS NOW")
      let droppedPin = MKPointAnnotation()
      droppedPin.coordinate = CLLocationCoordinate2D(
        latitude: memory.location.latitude ,
        longitude: memory.location.longitude
      )
      droppedPin.title = memory.title
      uiView.addAnnotation(droppedPin)
      
    }
    
  }

  func makeUIView(context: Context) -> MKMapView {
    print("MAKING VIEW")
    
    
    let mapView = MKMapView(frame: .zero)
    let user = viewController.currLocation
    user.loadLocation()
    
    
    
    //MAKING PIN BY HAND
//    let loc = Location()
//    loc.longitude = -79.946401
//    loc.latitude = 40.442609
//    let date1 = NSDate()
//    let happyTag = Tag(name: "Happy", color: "Yellow")
//    let pin1 = MemoryPin(title:"first memory", description: "description of the memory", addressStreet: "5000 Forbes Ave", addressCity: "Pittsburgh", addressState: "PA", addressZip: "15213",location: loc, tag:[happyTag], date: date1 as Date)
//    let pinArr: [MemoryPin] = [pin1]
//    let tagArr: [Tag] = [happyTag]
//
//    // Make user by hand
//    let claudiaUser = User(name: "Claudia Osorio", email: "cosorio@andrew.cmu.edu", allPins: pinArr, allTags: tagArr)
    
  
    //hello bah blah ablh
    //MAKING USER BY HAND
    
    
    for memory in viewModel.sampleUser.allPins{
      let droppedPin = MKPointAnnotation()
      droppedPin.coordinate = CLLocationCoordinate2D(
        latitude: memory.location.latitude ,
        longitude: memory.location.longitude
      )
      droppedPin.title = memory.title
      mapView.addAnnotation(droppedPin)
      
    }
    
    
    return mapView
  }
   
}

