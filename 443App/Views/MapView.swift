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
import Contacts
struct MapView: View {

  // Data for user pins
  @EnvironmentObject var userPins: UserPins
  // Used for tracking current location
  @State var trackingMode: MapUserTrackingMode = .follow
  @State var manager = CLLocationManager()
  @StateObject var managerDelegate = LocationDelegate()
  @ObservedObject var uvm: UserViewModel
  
  //NEHA
  @EnvironmentObject var mapData: MapViewModel
  
  
  
  @State var color="red";
  
  init(uvm: UserViewModel)
  {
    self.uvm = uvm
    
  }
  

  
  var body: some View {

        
    ZStack(alignment: .top){
      Map(coordinateRegion: $mapData.coordinateRegion,
              interactionModes: MapInteractionModes.all,
              showsUserLocation: true,
              userTrackingMode: $trackingMode,
              annotationItems: uvm.memoryPins) { place in
              
            // • If you want larger ballons:
            //MapMarker(coordinate: place.location.coordinates, tint: .blue)
            // • If you want the traditional pin:
            //MapPin(coordinate: place.location.coordinates)
            // • If you want a circle to focus on the location:
             MapAnnotation(coordinate: place.location.coordinates) {

              NavigationLink(destination: PinDetail(uvm: uvm, pin: place)){
                
              HStack {
                VStack(spacing: 0) {
                    let color = place.tags[0].color;
                    Image(systemName: "mappin.circle.fill")
                      .font(.title)
                      .foregroundColor(Color(color))

                    Image(systemName: "arrowtriangle.down.fill")
                      .font(.caption)
                      .foregroundColor(Color(color))
                      .offset(x: 0, y: -5)
                    Text(place.title).font(.caption)
                }
              }}
             }

          }
          .onAppear {
            manager.delegate = managerDelegate
          }
          .edgesIgnoringSafeArea(.all)
      
      NavigationLink(destination: SetPinLocationView(uvm: uvm)) {
        Text("Create")
      }
      .offset(y: 655)
      
      
    }
         
        

    
  }
  
}

  


