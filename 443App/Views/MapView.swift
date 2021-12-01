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
  @ObservedObject var uvm: UserViewModel
  
  
  //for search shit
  @EnvironmentObject var mapData: MapViewModel
  
  init(uvm: UserViewModel)
  {
    self.uvm = uvm
    
    
  }
  
  
  @State var coordinateRegion = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 40.444176, longitude: -79.945551),
    span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
  
  var body: some View {

        
    ZStack(alignment: .top){
          Map(coordinateRegion: $coordinateRegion,
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
                  Image(systemName: "mappin.circle.fill")
                    .font(.title)
                    .foregroundColor(.red)

                  Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(.red)
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
      
      
      
      //SEARCH BAR
      VStack(spacing:0){
        HStack{
          Image(systemName: "magnifyingglass").foregroundColor(.gray)
          TextField("Search", text: $mapData.searchTxt).colorScheme(.light)
          
        }.padding(.vertical, 10).padding(.horizontal).background(Color.white)
        //DISPLAYING RESULTS
        if !mapData.places.isEmpty && mapData.searchTxt != ""{
          ScrollView{
            VStack(spacing: 15){
              ForEach(mapData.places){place in
                Text(place.place.name ?? "").foregroundColor(.black).frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
                  .onTapGesture{
                    
                  }
                Divider()
                
              }
            }.padding(.top)
          }.background(Color.white)
        }
        
          
          
      }.padding()
      Spacer()
        .onChange(of: mapData.searchTxt, perform: { value in
          
          let delay=0.3
          
          DispatchQueue.main.asyncAfter(deadline: .now()+delay ){
            if value == mapData.searchTxt{
              self.mapData.searchQuery()
            }
          }
          
        })
      
      
      
      
      
      
    }
    
    
         
        

    
  }
  
}

  


