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

struct MapView: View {

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
          userTrackingMode: $trackingMode,
          annotationItems: userPins.allPins) { place in
        
        // • If you want larger ballons:
        //MapMarker(coordinate: place.location.coordinates, tint: .blue)
        
        // • If you want the traditional pin:
        //MapPin(coordinate: place.location.coordinates)
        
        // • If you want a circle to focus on the location:
         MapAnnotation(coordinate: place.location.coordinates) {
           
          
          NavigationLink(destination: PinDetail(pin: place)){
          HStack {
            
            VStack(spacing: 0) {
              
              Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.red)

              Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.red)
                .offset(x: 0, y: -5)
              Text(place.title).font(.caption)
            }
            
          }}.onTapGesture {
                              print("Test tapping")
                            
                          }
         }

      }
      .onAppear {
        manager.delegate = managerDelegate
      }
      .edgesIgnoringSafeArea(.all)
      .navigationBarItems(trailing: Button(action: {
        //to just set random pin
        userPins.setRandomPin()
        
        //to try and use set pin view
       
        
      }) {
          Image(systemName: "plus")
          Text("Add")
      })
    }
  }
  
}
  


