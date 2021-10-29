//
//  BottomBar.swift
//  443App
//
//  Created by Claudia Osorio on 10/28/21.
//

import Foundation
import SwiftUI


struct BottomBar: View {
 
  @ObservedObject var viewModel = ViewModel()
  let viewController = ViewController()
  
  var body: some View{
    TabView {
       Text("Journal View")
         .tabItem {
            Image(systemName: "phone.fill")
            Text("First Tab")
          }
      
      MapView(viewController: viewController, viewModel: viewModel)
           .tabItem {
              Image(systemName: "tv.fill")
              Text("Second Tab")
            }
      
      Text("User View")
           .tabItem {
              Image(systemName: "tv.fill")
              Text("Second Tab")
            }
      
      
      
    }
    
    
    
  }
}

