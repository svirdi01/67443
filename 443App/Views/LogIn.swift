//
//  LogIn.swift
//  443App
//
//  Created by Simran Virdi on 11/28/21.
//


import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
  
  let auth = Auth.auth()
  var isSignedin: Bool
  {
    
    return auth.currentUser != nil
  }
  func signIn(email: String, password: String)
  {
    
  }
  
  func signUp(email: String, password: String)
  {
    
  }
  
  
}

struct LogIn: View {
  
//  @StateObject var viewModel = ViewModel()
  
  
  @State var isNavigationBarHidden: Bool = true
  @State var emailField: String = ""
  @State var passField: String = ""
  @ObservedObject var uvm: UserViewModel
  
  
  init(userviewmodel: UserViewModel)
  {
    uvm = userviewmodel
  }
  
  var body: some View
  {
    // BottomBar(viewModel: viewModel, viewController: viewController)
    
    NavigationView {
      VStack
      {
        Text("Log In")
              .font(.body)
              .foregroundColor(.primary)
        
        HStack {
          Text("Email")
            .fontWeight(.bold)
            .padding(.leading)
          TextField("Email Address", text: $emailField)
            .padding(.trailing)
          
        }.padding()
        
        HStack {
          Text("Password")
            .fontWeight(.bold)
            .padding(.leading)
          TextField("Password", text: $passField)
            .padding(.trailing)
        }.padding()
        
        NavigationLink(destination: BottomBar(userviewmodel: uvm))
        {
            
            Text("Log In")
        }
        .simultaneousGesture(TapGesture().onEnded{
                            print("Hello world!")
        })
        
        
      
    }

     }
   
    
 

    }
 
   
      
    
   
  }






