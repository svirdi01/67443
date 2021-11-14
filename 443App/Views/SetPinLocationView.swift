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


  @State var coordinateRegion = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 40.444176, longitude: -79.945551),
    span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))

  var body: some View {
    NavigationView {
      Map(coordinateRegion: $coordinateRegion,
          interactionModes: MapInteractionModes.all,
          showsUserLocation: true,
          userTrackingMode: $trackingMode)

      .edgesIgnoringSafeArea(.all)

    }
  }

}

//

