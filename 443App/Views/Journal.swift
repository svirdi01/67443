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
  @State var option: Int = 3
  
  init(uvm: UserViewModel)
  {
    self.uvm = uvm
    displayedPins = self.uvm.memoryPins
    MapPinsView(uvm: uvm)
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
        
        HStack{
          Spacer()
          Menu{
            Picker(selection: $option, label: Text("Sort Pins"))
            {
              Text("Date Ascending").tag(1)
              Text("Date Descending").tag(2)
              Text("Alphabetical").tag(3)
            }
            .onChange(of: option)
            {
                newValue in
                print("option changed to \(option)!")
              displayPins()
            }
          }
          label: {
            Label("Sort Pins", systemImage: "arrow.up.arrow.down")
          }
        
          
        }
          

        if (searchField == "")
        {
          if(option == 3)
          
          {
                  List {
                ForEach(uvm.memoryPins.sorted(by: {$0.title < $1.title}))
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
          if(option != 3)
          {
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
      .navigationBarTitle("")
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)
  }
  
  
  func displayPins() {
    print("IN HERE")
      
    if searchField == "" {
        
        if(option == 1)
        {
          displayedPins = uvm.memoryPins.sorted(by: {$0.date < $1.date})
        }
        else if(option == 2)
        {
          displayedPins = uvm.memoryPins.sorted(by: {$0.date > $1.date})
        }
        else
        {
          displayedPins = uvm.memoryPins.sorted(by: {$0.title < $1.title})
        }
      }
      else
      {
        if(option == 1)
        {
          displayedPins = uvm.filteredmemoryPins.sorted(by: {$0.date < $1.date})
        }
        else if(option == 2)
        {
          displayedPins = uvm.filteredmemoryPins.sorted(by: {$0.date > $1.date})
        }
        else
        {
          displayedPins = uvm.filteredmemoryPins.sorted(by: {$0.title < $1.title})
        }
        
      }
    }
  
  
  

  
  
    
  
  
}
