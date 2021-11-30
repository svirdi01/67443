//
//  LogIn.swift
//  443App
//
//  Created by Simran Virdi on 11/28/21.
//


import SwiftUI
import FirebaseAuth



struct LogIn: View {
  
//  @StateObject var viewModel = ViewModel()
  
  
  @State var isNavigationBarHidden: Bool = true
  @State var emailField: String = ""
  @State var passField: String = ""
  @ObservedObject var svm: AppViewModel
  @ObservedObject var uvm: UserViewModel
  
  
  init(userviewmodel: UserViewModel, signinviewmodel: AppViewModel)
  {
    uvm = userviewmodel
    svm = signinviewmodel
    
  }
  
  var body: some View
  {
    // BottomBar(viewModel: viewModel, viewController: viewController
      VStack
      {
        Text("Log In")
              .font(.body)
              .foregroundColor(.primary)
        
        HStack {
          TextField("Email Address", text: $emailField)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(.trailing)
          
        }.padding()
        
        HStack {
          SecureField("Password", text: $passField)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(.trailing)
        }.padding()
        
        
        Button(action: {
          
         guard !emailField.isEmpty, !passField.isEmpty else
         {
            return
          }
          svm.signIn(email: emailField, password: passField)
          
        }, label: {
          Text("Log In")
        })
        
        NavigationLink("Create Acount", destination: SignUpView(userviewmodel: uvm, signinviewmodel: svm))
        
       // NavigationLink(destination: BottomBar(userviewmodel: uvm))
        //{
            
            //Text("Log In")
        //}
        //.simultaneousGesture(TapGesture().onEnded{
                           // print("Hello world!")
        //})
 
    }

}
 
  }






struct SignUpView: View {
  
//  @StateObject var viewModel = ViewModel()
  @State var isNavigationBarHidden: Bool = true
  @State var emailField: String = ""
  @State var passField: String = ""
  @State var name: String = ""
  @ObservedObject var svm: AppViewModel
 
  @ObservedObject var uvm: UserViewModel
  
  
  init(userviewmodel: UserViewModel, signinviewmodel: AppViewModel)
  {
    uvm = userviewmodel
    svm = signinviewmodel
    
  }
  
  var body: some View
  {
    // BottomBar(viewModel: viewModel, viewController: viewController
      VStack
      {
        Text("Create Account")
              .font(.body)
              .foregroundColor(.primary)
        
        HStack {
          TextField("Email Address", text: $emailField)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(.trailing)
          
        }.padding()
        
        HStack {
          TextField("Name", text: $name)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(.trailing)
          
        }.padding()
        
        
        
        HStack {
          TextField("Password", text: $passField)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(.trailing)
        }.padding()
        
        
        Button(action: {
          
          guard !emailField.isEmpty, !passField.isEmpty else
          {
            return
          }
          svm.signUp(email: emailField, password: passField, name: name)
          
        }, label: {
          Text("Sign Up")
        })
        
       
       // NavigationLink(destination: BottomBar(userviewmodel: uvm))
        //{
            
            //Text("Log In")
        //}
        //.simultaneousGesture(TapGesture().onEnded{
                           // print("Hello world!")
        //})
 
    }

}
 
   
      
    
   
}
