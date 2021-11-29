//
//  LogIn.swift
//  443App
//
//  Created by Simran Virdi on 11/28/21.
//


import SwiftUI

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






