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
  let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
  let darkBlue = Color(red: 6/255.0, green: 31/255.0, blue: 74/255.0)
  let lightBlue = Color(red: 220/255.0, green: 249/255.0, blue: 243/255.0)
  let darkPink = Color(red: 254/255.0, green: 218/255.0, blue: 232/255.0)

  
  
  init(userviewmodel: UserViewModel, signinviewmodel: AppViewModel)
  {
    uvm = userviewmodel
    svm = signinviewmodel
    
  }
  
  var body: some View
  {
    // BottomBar(viewModel: viewModel, viewController: viewController
    
    ZStack{
      darkBlue
          .ignoresSafeArea()
      VStack
      {
        VStack{
        Image("logo")
//          .resizable()
          .frame(width: 120, height: 120)
          .padding()

//        Spacer()
        

        }
        
        
        VStack{
        Text("Email Address")
          .foregroundColor(Color.white)
        HStack {

          TextField("Email Address", text: $emailField)
            .foregroundColor(Color.black)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .padding(.leading, 20)
            .padding(.trailing, 20)


        }
//        .padding()
        
        Text("Password")
          .foregroundColor(Color.white)
        HStack {
          SecureField("Password", text: $passField)
            .foregroundColor(Color.black)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
//        .padding()
        
        
        Button(action: {
          
         guard !emailField.isEmpty, !passField.isEmpty else
         {
            return
          }
          svm.signIn(email: emailField, password: passField)
          
        }, label: {
          Text("Log In")
            .padding(.leading, 55)
            .padding(.trailing, 55)
            .padding(.bottom, 7)
            .padding(.top, 7)
            .foregroundColor(darkBlue)
            .font(Font.headline.weight(.bold))
            .background(lightBlue)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(darkBlue, lineWidth: 4)
            )
        })
        
        NavigationLink("Create Account", destination: SignUpView(userviewmodel: uvm, signinviewmodel: svm))
          .padding(.bottom, 7)
          .padding(.top, 7)
          .padding(.leading, 20)
          .padding(.trailing, 20)

          .foregroundColor(darkBlue)
          .font(Font.headline.weight(.bold))
          .background(darkPink)
          .overlay(
              RoundedRectangle(cornerRadius: 5)
                  .stroke(darkBlue, lineWidth: 4)
          )
          

          
        }
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
 
  }






struct SignUpView: View {
  
//  @StateObject var viewModel = ViewModel()
  @State var isNavigationBarHidden: Bool = true
  @State var emailField: String = ""
  @State var passField: String = ""
  @State var name: String = ""
  @State private var showingAlert = false
  @ObservedObject var svm: AppViewModel
 
  @ObservedObject var uvm: UserViewModel
  
  @State var showImagePicker: Bool = false
  @State var image: UIImage? = nil
  
  let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
  let darkBlue = Color(red: 6/255.0, green: 31/255.0, blue: 74/255.0)
  let lightBlue = Color(red: 220/255.0, green: 249/255.0, blue: 243/255.0)
  let darkPink = Color(red: 254/255.0, green: 218/255.0, blue: 232/255.0)

    var displayImage: Image? {
      if let picture = image {
        return Image(uiImage: picture)
      } else {
        return nil
      }
    }
  
  
  init(userviewmodel: UserViewModel, signinviewmodel: AppViewModel)
  {
    uvm = userviewmodel
    svm = signinviewmodel
    
  }
  
  var body: some View
  {
    // BottomBar(viewModel: viewModel, viewController: viewController
    
    ZStack{
      darkBlue
          .ignoresSafeArea()
      VStack
      {
        VStack{
        Text("Create Account")
          .font(.largeTitle)
          .fontWeight(.semibold)
          .foregroundColor(Color.white)
          .padding()
          
          Spacer()
          
        displayImage?.resizable().clipShape(Circle()).scaledToFit().padding()
          
              Button(action: {
                self.showImagePicker = true
              }) {
                Text("Add Profile Picture")
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)

                    .foregroundColor(darkBlue)
                    .font(Font.headline.weight(.bold))
                    .background(darkPink)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(darkBlue, lineWidth: 4)
                    )
              }.padding()
        }
        
        VStack{
          Text("Email Address")
            .foregroundColor(Color.white)
          HStack {

            TextField("Email Address", text: $emailField)
              .foregroundColor(Color.black)
              .disableAutocorrection(true)
              .autocapitalization(.none)
              .padding()
              .background(lightGreyColor)
              .cornerRadius(5.0)
              .padding(.bottom, 20)
              .padding(.leading, 20)
              .padding(.trailing, 20)


          }
  //        .padding()
          
          Text("Password")
            .foregroundColor(.primary)
          HStack {
            SecureField("Password", text: $passField)
              .foregroundColor(Color.black)
              .disableAutocorrection(true)
              .autocapitalization(.none)
              .padding()
              .background(lightGreyColor)
              .cornerRadius(5.0)
              .padding(.bottom, 20)
              .padding(.leading, 20)
              .padding(.trailing, 20)
          }
        }
        

        
        Button(action: {
          
          guard !emailField.isEmpty, !passField.isEmpty else
          {
            return
          }
          showingAlert = true
          svm.signUp(email: emailField, password: passField, name: name,  picture: self.image)
          
        },
        label: {
          Text("Sign Up")
            .padding(.bottom, 7)
            .padding(.top, 7)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .foregroundColor(darkBlue)
            .font(Font.headline.weight(.bold))
            .background(lightBlue)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(darkBlue, lineWidth: 4)
            )
        }
        )
        
       
       // NavigationLink(destination: BottomBar(userviewmodel: uvm))
        //{
            
            //Text("Log In")
        //}
        //.simultaneousGesture(TapGesture().onEnded{
                           // print("Hello world!")
        //})
 
    }
      .alert(isPresented: $showingAlert) {
                  Alert(title: Text("Logging In!"), message: Text("It will take a second!"), dismissButton: .default(Text("Got it!")))
              }
      .sheet(isPresented: $showImagePicker)
        {
              PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)
        }
    }
}
 
   
      
    
   
}
