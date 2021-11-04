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
  @StateObject var viewModel: ViewModel
  @ObservedObject var viewController: ViewController
  
  var body: some View
  {
  
    TabView {
      NavigationView {
        var pins =  viewModel.getPins()
        List {
          ForEach(pins)
          { pin in
            NavigationLink(destination: PinDetail(pin: pin))
            {
              PinRow(pin: pin)
            }
          }
        }.onAppear(perform: {
          pins = viewModel.getPins()
          })
        .navigationBarTitle("Pins")
        .navigationBarItems(trailing:
                              NavigationLink(destination: AddPin(viewModel: viewModel)) {
              Image(systemName: "plus")
          }
        )
      }.tabItem {
            Image(systemName: "phone.fill")
            Text("Journal")
          }
      
      NavigationView {
        ZStack {
          MapView(viewController: viewController, viewModel: viewModel)
          NavigationLink(destination: AddPin(viewModel: viewModel)) {
              Text("Create")
          }
          .offset(y: 275)

          }
        .navigationBarTitle("Back")
        .navigationBarHidden(self.isNavigationBarHidden)
        .onAppear {
            self.isNavigationBarHidden = true
        }
        }
           .tabItem {
              Image(systemName: "tv.fill")
              Text("Map")
            }
      
      Profile(viewModel: viewModel)
           .tabItem {
              Image(systemName: "tv.fill")
              Text("Profile")
            }
      
      
      
    }
    
    
    
  }

}

