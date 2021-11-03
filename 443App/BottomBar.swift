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
  @ObservedObject var viewModel: ViewModel
  @ObservedObject var viewController: ViewController
  
  var body: some View
  {
   
    TabView {
      NavigationView {
        List {
          ForEach(viewModel.sampleUser.allPins)
          { pin in
            NavigationLink(destination: PinDetail(pin: pin))
            {
              PinRow(pin: pin)
            }
          }
        }
        .navigationBarTitle("Pins")
        .navigationBarItems(trailing:
          NavigationLink(destination: AddPin(viewModel: viewModel)) {
              Image(systemName: "plus")
          }
        )
      }.tabItem {
            Image(systemName: "phone.fill")
            Text("First Tab")
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
              Text("Second Tab")
            }
      
      Profile(viewModel: viewModel)
           .tabItem {
              Image(systemName: "tv.fill")
              Text("Second Tab")
            }
      
      
      
    }
    
    
    
  }
}

