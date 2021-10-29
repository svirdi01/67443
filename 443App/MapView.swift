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
  let viewController: ViewController
  let viewModel: ViewModel
//  @ObservedObject var viewModel: ViewModel
 
  
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
    
    
    
    //MAKING PIN BY HAND
    let loc = Location()
    loc.longitude = -79.946401
    loc.latitude=40.442609
    let date1 = NSDate()
    let pin1 = MemoryPin(title:"some memory", description:"description of some memory", address:"address of some memory", location:loc,tag:[], date: date1 as Date)
    let pinArr: [MemoryPin] = [pin1]
    let happyTag = Tag(name:"Happy", color:"Yellow")
    let tagArr: [Tag] = [happyTag]
    
    
    //MAKING USER BY HAND
    
    
    let nehaUser = User(name: "NEHA JOSHI" , email: "nehajosh@andrew.cmu.edu", allPins: pinArr, allTags: tagArr)
    
    
    
    for memory in nehaUser.allPins{
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

