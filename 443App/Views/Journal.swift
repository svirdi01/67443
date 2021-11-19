//
//  Journal.swift
//  443App
//
//  Created by Claudia Osorio on 11/11/21.
//

import Foundation
import SwiftUI
 
struct Journal: View {
  //@EnvironmentObject var userPins: UserPins
  @ObservedObject var uvm: UserViewModel
  
  init(uvm: UserViewModel)
  {
    self.uvm = uvm
  }
  
  var body: some View {
    NavigationView {

      List {
        ForEach(uvm.memoryPins)
        { pin in
          NavigationLink(destination: PinDetail(uvm: uvm, pin: pin))
          {
            PinRow(pin: pin)
          }
        }
      }
      .navigationBarTitle("My Memories")
      .navigationBarItems(trailing:
        NavigationLink(destination: AddPin(uvm: uvm)) {
            Image(systemName: "plus")
        }
      )
    }
  }
  
  
}
