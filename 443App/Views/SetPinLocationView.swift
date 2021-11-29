//
//  SetPinLocationView.swift
//  443App
//
//  Created by Neha Joshi on 11/14/21.
//

import Foundation
import MapKit
import SwiftUI
import Combine

struct SetPinLocationView: View {
  // Data for user pins
  @EnvironmentObject var userPins: UserPins
  // Used for tracking current location
  @State var trackingMode: MapUserTrackingMode = .follow
  @State var manager = CLLocationManager()
  @StateObject var managerDelegate = LocationDelegate()
  @ObservedObject var uvm: UserViewModel
  
  
  
  init(uvm: UserViewModel)
  {
    self.uvm = uvm
    
    
  }

  @State var coordinateRegion = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 40.444176, longitude: -79.945551),
    span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))

  var body: some View {
    ZStack{
      NavigationView {
        Map(coordinateRegion: $coordinateRegion,
            interactionModes: MapInteractionModes.all,
            showsUserLocation: true,
            userTrackingMode: $trackingMode)

        .edgesIgnoringSafeArea(.all)

      }
      /// OVERLAYED PIN
      VStack(spacing: 0) {
        Image(systemName: "mappin.circle.fill")
          .font(.title)
          .foregroundColor(.red)

        Image(systemName: "arrowtriangle.down.fill")
          .font(.caption)
          .foregroundColor(.red)
          .offset(x: 0, y: -5)
        Text("NEW PIN").font(.caption)
      }.offset(y: 50)
        ///OVERLAYED PIN
      
      
      
      //OVERLAYED PIN 2
//      MapAnnotation(coordinate: coordinateRegion.center) {
//       HStack {
//         VStack(spacing: 0) {
//           Image(systemName: "mappin.circle.fill")
//             .font(.title)
//             .foregroundColor(.red)
//
//           Image(systemName: "arrowtriangle.down.fill")
//             .font(.caption)
//             .foregroundColor(.red)
//             .offset(x: 0, y: -5)
//           Text("CENTER PIN").font(.caption)
//         }
//
//       }
//      }
      // OVERLAYED PIN 2
      
      /// DROP PIN BUTTON
      
      NavigationLink(destination: AddPin(uvm: uvm, long: coordinateRegion.center.longitude.description, lat: coordinateRegion.center.latitude.description)) {
        Text("DROP PIN HERE")}.offset(y: 200)
      
      
      ///DROP PIN BUTTON
    
  }
  }

}

//

