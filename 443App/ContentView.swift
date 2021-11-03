//
//  ContentView.swift
//  app
//
//  Created by Neha Joshi on 9/28/21.
//

import SwiftUI

struct ContentView: View {
  //might make this add state object - would not be observed object
  //look at this yourself see if paul hudsons thing will lhelp colve this problem
  //if not ProfH will look at this
  //SLACK HIM AFTER TROUBLE SHOOTING
  //start thinkgin about firebase
  @StateObject var viewModel = ViewModel()
  @ObservedObject var viewController = ViewController()
  
  @State private var showingAlert = false
    var body: some View {
  
      BottomBar(viewController: viewController, viewModel:viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


