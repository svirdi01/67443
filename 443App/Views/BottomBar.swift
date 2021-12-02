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

        Journal(uvm: uvm)
          .tabItem {
              Image(systemName: "book.circle")
              Text("Journal")
            }
          .tag(1)
          .navigationBarTitle("")
          .navigationBarHidden(true)
          .navigationBarBackButtonHidden(true)
      
        MapPinsView(uvm: uvm)
          .tabItem {
            Image(systemName: "map.fill")
            Text("Map")
          }
          .tag(2)
          .navigationBarTitle("")
          .navigationBarHidden(true)
          .navigationBarBackButtonHidden(true)
      
        Profile(uvm: uvm)
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
