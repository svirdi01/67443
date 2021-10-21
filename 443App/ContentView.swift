//
//  ContentView.swift
//  app
//
//  Created by Neha Joshi on 9/28/21.
//

import SwiftUI

struct ContentView: View {
  let viewController = ViewController()
  
  @State private var showingAlert = false
    var body: some View {
      NavigationView {
         VStack {
          Text("Welcome to APPNAME!")
          Spacer()
           NavigationLink(destination: MapView(viewController: viewController).navigationBarTitle("All yo memories")) {
             Text("Lets Begin!")
           }
           Spacer()
         }
         .alert(isPresented: $showingAlert) {
           Alert(title: Text(viewController.generateTitle()), message: Text(viewController.generateMessage()))
         }
       }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


