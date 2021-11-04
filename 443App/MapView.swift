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
  @StateObject var viewModel: ViewModel
  
  
  func makeCoordinator() -> Coordinator {
      Coordinator()
  }

 
  
  func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
    
    print("UPDATING UI VIEW")
    let user = viewController.currLocation
    user.loadLocation()
    
    uiView.showsUserLocation = true
    
    
    let coordinate = CLLocationCoordinate2D(latitude: viewController.currLocation.latitude, longitude: viewController.currLocation.longitude)
    
    
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    uiView.setRegion(region, animated: true)
    
    //need to flush all annotations at start of update UI view
    for memory in viewModel.sampleUser.allPins{
      print("MAKING PINS NOW")
      let droppedPin = MyCustomPointAnnotation(pin:memory)
      droppedPin.coordinate = CLLocationCoordinate2D(
        latitude: memory.location.latitude ,
        longitude: memory.location.longitude
      )
      droppedPin.title = memory.title
      
      uiView.addAnnotation(droppedPin)
     // let button = UIButton(type: UIButton.ButtonType.detailDisclosure) as UIButton

      
    }

    
  }

  func makeUIView(context: Context) -> MKMapView {
    print("MAKING VIEW")
    
    
    let mapView = MKMapView(frame: .zero)
    let user = viewController.currLocation
    user.loadLocation()
    
    
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

