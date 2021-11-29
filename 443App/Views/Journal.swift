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
  @State var searchField: String = ""
  @State var displayedPins = [MemoryPin]()
  
  init(uvm: UserViewModel)
  {
    self.uvm = uvm
    displayedPins = self.uvm.memoryPins
  }
  
  var body: some View {
    let binding = Binding<String>(get: {
      self.searchField
    }, set: {
      displayedPins = uvm.memoryPins
      self.searchField = $0
      uvm.search(searchText: self.searchField)
      self.displayPins()
    })
    
    NavigationView {
      
      
      VStack{
        TextField(" Search My Journal:", text: binding).offset(x: 20)

        if (searchField == ""){
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
        NavigationLink(destination: SetPinLocationView(uvm: uvm)) {
            Image(systemName: "plus")
        }
      )
          
        }
        else{
          List {
            ForEach(displayedPins)
            { pin in
              NavigationLink(destination: PinDetail(uvm: uvm, pin: pin))
              {
                PinRow(pin: pin)
              }
            }
          }
          .navigationBarTitle("My Memories")
          .navigationBarItems(trailing:
            NavigationLink(destination: SetPinLocationView(uvm: uvm)) {
                Image(systemName: "plus")
            }
          )
        }
        
      }
    }.onAppear(perform: displayPins)

   
    
  }
  
  
    func displayPins() {
      displayedPins = uvm.memoryPins
      if searchField == "" {
        displayedPins = uvm.memoryPins
      } else {
        displayedPins = uvm.filteredmemoryPins
      }
    }
    

  
  
}
