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
  }
  
  var body: some View {
    
    let binding = Binding<String>(get: {
      self.searchField
    }, set: {
      self.searchField = $0
      uvm.search(searchText: self.searchField)
      self.displayPins()
    })
    
    NavigationView {
      
      
      VStack{
        TextField("Search:", text: binding).offset(x: 20)

        if(searchField != ""){

      List {
        ForEach(self.displayedPins)
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
        else{
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

   
    
  }
  
  func loadData() {
    displayedPins = uvm.memoryPins
  }
  
  
    func displayPins() {
      if searchField != "" {
        displayedPins = uvm.filteredmemoryPins
      }
    }
    

  
  
}
