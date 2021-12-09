//
//  BottomBar.swift
//  443App
//
//  Created by Claudia Osorio on 10/28/21.
//
import Foundation
import SwiftUI


struct BottomBar: View {
  @State var isNavigationBarHidden: Bool = true
  var userPins: UserPins
  var userTags: UserTags
  @ObservedObject var uvm: UserViewModel
  @State private var selection = 2
  // NEHAS CODE
  @StateObject var MapData = MapViewModel()
  @EnvironmentObject var signinviewModel: AppViewModel
//  @StateObject var coordinateRegion = MKCoordinateRegion(
//    center: CLLocationCoordinate2D(latitude: 40.444176, longitude: -79.945551),
//    span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
  //NEHAS CODE
  
  
  init(userviewmodel: UserViewModel)
  {
    
    uvm = userviewmodel
    print("IN  BOTTOM BARR")
    print(userviewmodel.user.name)
    print(userviewmodel.memoryPins)
    self.userPins = UserPins(forUser: userviewmodel.user, allPins: userviewmodel.memoryPins)
    self.userTags = UserTags( forUser:userviewmodel.user, allTags: userviewmodel.allTags )
    
  }
  
  var body: some View
  {
    
    NavigationView {
      
      TabView(selection: $selection) {

        Journal(uvm: uvm).environmentObject(MapData)
          .tabItem {
              Image(systemName: "book.circle")
              Text("Journal")
            }
          .tag(1)
          .navigationBarTitle("")
          .navigationBarHidden(true)
          .navigationBarBackButtonHidden(true)
      
        MapPinsView(uvm: uvm).environmentObject(MapData)
          .tabItem {
            Image(systemName: "map.fill")
            Text("Map")
          }
          .tag(2)
          .navigationBarTitle("")
          .navigationBarHidden(true)
          .navigationBarBackButtonHidden(true)
      
        Profile(uvm: uvm)
          .environmentObject(signinviewModel)
          .tabItem {
            Image(systemName: "person.fill")
            Text("Profile")
          }
          .tag(3)
          .navigationBarTitle("")
          .navigationBarHidden(true)
          .navigationBarBackButtonHidden(true)
      }
      .environmentObject(userPins)
      .environmentObject(userTags)
      .navigationBarTitle("")
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)
    }
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .navigationBarBackButtonHidden(true)
    
  }
 
}
