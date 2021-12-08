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
  let darkBlue = Color(red: 7/255.0, green: 30/255.0, blue: 75/255.0)
  let lightBlue = Color(red: 220/255.0, green: 249/255.0, blue: 243/255.0)

  
  
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
      
      
      
      /// DROP PIN BUTTON
      
      NavigationLink(destination: AddPin(uvm: uvm, long: coordinateRegion.center.longitude.description, lat: coordinateRegion.center.latitude.description)) {
        Text("DROP PIN HERE")
          .padding()
          .foregroundColor(darkBlue)
          .font(Font.headline.weight(.bold))
          .background(lightBlue)
          .overlay(
              RoundedRectangle(cornerRadius: 5)
                  .stroke(darkBlue, lineWidth: 4)
          )
        
      }.offset(y: 200)
      
      
      ///DROP PIN BUTTON
    
  }
  }

}

//

