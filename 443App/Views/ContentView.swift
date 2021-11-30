//
//  ContentView.swift
//  app
//
//  Created by Neha Joshi on 9/28/21.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
  @Published var signedIn : Bool = false
  
  let auth = Auth.auth()
  var isSignedIn: Bool
  {
    
    return auth.currentUser != nil
  }
  func signIn(email: String, password: String)
  {
    auth.signIn(withEmail: email, password: password)
    { [self] result, error in
      guard result != nil, error == nil else
      {
        return
      }
      
      DispatchQueue.main.async
      {
        print("SIGNED IN")
        self.signedIn = true
        print(self.signedIn)
        
      }
      
      
     
    }
  }
  
  func signUp(email: String, password: String)
  {
    auth.createUser(withEmail: email, password: password)
    { result, error in
        guard result != nil, error == nil else
        {
          return
        }
      
      
      
      
      DispatchQueue.main.async
      {
        print("SIGNED IN")
        self.signedIn = true
        print(self.signedIn)
        
      }
      
      
      
    }
  }
  
  
}



struct ContentView: View {
  
//  @StateObject var viewModel = ViewModel()
  
  
  @State private var showingAlert = false
  @ObservedObject var userviewmodel = UserViewModel()
  @ObservedObject var signinviewModel = AppViewModel()

  init()
  {
    userviewmodel.fetchUser()
    
  
  }
  
  var body: some View
  {
    NavigationView {
      if signinviewModel.signedIn{
        BottomBar(userviewmodel: userviewmodel)
        
      }
      else
      {
        LogIn(userviewmodel: userviewmodel, signinviewmodel: signinviewModel)
      }
    }
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .navigationBarBackButtonHidden(true)
    // BottomBar(viewModel: viewModel, viewController: viewController)

    
   
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




