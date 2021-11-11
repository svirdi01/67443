//
//  ProfileHeader.swift
//  443App
//
//  Created by Claudia Osorio on 10/31/21.
//
 
import Foundation
import SwiftUI
 
struct Profile: View {
  
  @EnvironmentObject var userPins: UserPins
  
  var body: some View {
    
    NavigationView {
      PinCountWidget()
      .navigationBarItems(trailing: Button(action: {
        userPins.setRandomPin()
      }) {
          Image(systemName: "plus")
          Text("Add")
      })
    }
  }
}
