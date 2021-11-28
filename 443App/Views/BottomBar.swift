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
  
  
  init(userviewmodel: UserViewModel)
  {
    
    uvm = userviewmodel
//    print("IN  BOTTOM BARR")
//    print(userviewmodel.user.name)
//    print(userviewmodel.memoryPins)
    print(userviewmodel.filteredmemoryPins)
    self.userPins = UserPins(forUser: userviewmodel.user, allPins: userviewmodel.memoryPins)
    self.userTags = UserTags( forUser:userviewmodel.user, allTags: userviewmodel.allTags )
    
  }
  
  var body: some View
  {
    
      
    
      TabView {

        Journal(uvm: uvm)
          .tabItem {
              Image(systemName: "book.circle")
              Text("Journal")
            }
      
        MapPinsView(uvm: uvm)
          .tabItem {
            Image(systemName: "map.fill")
            Text("Map")
          }
      
        Profile(uvm: uvm)
          .tabItem {
            Image(systemName: "person.fill")
            Text("Profile")
          }
      }
    .environmentObject(userPins)
    .environmentObject(userTags)
    
  }
}
