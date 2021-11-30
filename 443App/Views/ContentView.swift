//
//  ContentView.swift
//  app
//
//  Created by Neha Joshi on 9/28/21.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

class AppViewModel: ObservableObject {
  @Published var signedIn : Bool = false
  @Published var userID: String = ""
  @ObservedObject var userviewmodel = UserViewModel()
  
  let auth = Auth.auth()
  let db =  Firestore.firestore()
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
      
      self.userviewmodel.fetchUser(userID: Auth.auth().currentUser?.uid ?? "1")
      
     
    }
  }
  
  func signUp(email: String, password: String, name: String)
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
        
        self.db.collection("Users").document(Auth.auth().currentUser?.uid ?? "1").setData( [
          "email": email,
          "name": name
        
        ])
        
        print(Auth.auth().currentUser?.uid)
        
        self.userviewmodel.fetchUser(userID: Auth.auth().currentUser?.uid ?? "1")
        
        print("USER ID:")
        print(self.userviewmodel.user.userID)
        
        
      }
      
      
      
    }
  }
  
  
}



struct ContentView: View {
  
//  @StateObject var viewModel = ViewModel()
  
  
  @State private var showingAlert = false
  @ObservedObject var signinviewModel = AppViewModel()

  
  var body: some View
  {
    NavigationView {
      if signinviewModel.signedIn{
        
        
        BottomBar(userviewmodel: signinviewModel.userviewmodel)
        
       
        
      }
      else
      {
        LogIn(userviewmodel: signinviewModel.userviewmodel, signinviewmodel: signinviewModel)
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




