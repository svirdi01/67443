//
//  BottomBar.swift
//  443App
//
//  Created by Claudia Osorio on 10/28/21.
//
import Foundation
import SwiftUI


struct BottomBar2: View {
 
  @State var isNavigationBarHidden: Bool = true
  
  var userPins = UserPins(forUser: User(name: "Prof. H", email: "profh@cmu.edu"))
  
  var body: some View{
    TabView {
      PinView()
      .tabItem {
        Image(systemName: "pin.fill")
        Text("Pins")
      }
      
      MapPinsView()
      .tabItem {
        Image(systemName: "map.fill")
        Text("Map")
      }
      
      Profile()
      .tabItem {
        Image(systemName: "person.fill")
        Text("Profile")
      }
    }
    .environmentObject(userPins)
      
    
    
    
  }
  func buttonText() -> String {
    return "Create"
  }
}
