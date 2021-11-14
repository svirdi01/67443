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

  
  
  init(user: User)
  {
    self.userPins = UserPins(forUser: user)
  }
  
  var body: some View
  {
    TabView {

      Journal()
      .tabItem {
            Image(systemName: "book.circle")
            Text("Journal")
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
}
