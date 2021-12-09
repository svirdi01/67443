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
  
  //NEHA
  @StateObject var mapData = MapViewModel()
  //NEHAS EDITS

  //NEHA
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
    
    ZStack(){
      
      NavigationView {
        //mapData.reFocus()
        Map(coordinateRegion: $mapData.coordinateRegion,
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
      NavigationLink(destination: AddPin(uvm: uvm, long: mapData.getLong(), lat: mapData.getLat())) {
        Text("DROP PIN HERE")
          .padding(.bottom, 7)
          .padding(.top, 7)
          .padding(.leading, 20)
          .padding(.trailing, 20)
          .foregroundColor(darkBlue)
          .font(Font.headline.weight(.bold))
          .background(lightBlue)
          .overlay(
              RoundedRectangle(cornerRadius: 5)
                  .stroke(darkBlue, lineWidth: 4)
          )

      }.offset(y: 150)
      ///DROP PIN BUTTON
      
      
  
      // GO TO USER LOCATION BUTTON
      VStack{
        Spacer()
        VStack{
          Button(action: {
            print($mapData.coordinateRegion.center)
            //mapData.reFocus()
            
          }, label: {
            Image(systemName: "location.fill").font(.title2).padding(10).background(Color.primary).clipShape(Circle())
          })
        }.frame(maxWidth: .infinity, alignment: .trailing).padding()
      }
      // GO TO USER LOCATION BUTTON
    
  }
    
    ZStack(alignment: .top)
    {
      //SEARCH BAR;
      VStack(spacing:0)
      {
        HStack{
          Image(systemName: "magnifyingglass").foregroundColor(.gray)
          TextField("Search Location", text: $mapData.searchTxt).colorScheme(.light)
          
        }.padding(.vertical, 10).padding(.horizontal).background(Color.white)
        //DISPLAYING RESULTS
        if !mapData.places.isEmpty && mapData.searchTxt != ""{
          ScrollView{
            VStack(spacing: 15){
              ForEach(mapData.places){place in
                VStack{
                  let res = place.place
                  let resLoc = res.location
                  let city = res.postalAddress?.city
                  let state = res.postalAddress?.state
                Text(res.name ?? "")
                  .foregroundColor(.black)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .padding(.leading).onTapGesture{mapData.focusLocation(location: resLoc!)}
                  //.onTapGesture{print(type(of: resLoc))}
                
                Text((city ?? "")+", "+(state ?? "")).font(Font.system(size: 12, design: .default)).foregroundColor(.black).frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
                Divider()
                }
                
              }
            }.padding(.top)
          }.background(Color.white)
        }
      }.padding()
      .frame(alignment: .topLeading)
      Spacer()
        .onChange(of: mapData.searchTxt, perform: { value in
          //CHANGE THIS TO ALTER SEARCH SUGGESTION SPEED
          let delay=0.3
          DispatchQueue.main.asyncAfter(deadline: .now()+delay ){
            if value == mapData.searchTxt{
              self.mapData.searchQuery()
            }
          }
        })
      
      //SEARCH BAR
      
    }
    
    
    
    
      
    
    
  }

}

//

