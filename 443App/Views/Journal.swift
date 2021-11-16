//
//  Journal.swift
//  443App
//
//  Created by Claudia Osorio on 11/11/21.
//

import Foundation
import SwiftUI
 
struct Journal: View {
  @EnvironmentObject var userPins: UserPins
  
  var body: some View {
    NavigationView {

      List {
        ForEach(userPins.allPins)
        { pin in
          NavigationLink(destination: PinDetail(pin: pin))
          {
            PinRow(pin: pin)
          }
        }
      }
      .navigationBarTitle("My Memories")
      .navigationBarItems(trailing:
        NavigationLink(destination: AddPin()) {
            Image(systemName: "plus")
        }
      )
    }
  }
  
  
}
