//
//  PinDetail.swift
//  443App
//
//  Created by Simran Virdi on 11/3/21.
//
import Foundation
import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct PinDetail: View {

  @ObservedObject var uvm: UserViewModel
    var pin: MemoryPin
    var width: Double
    @State private var imageURL = URL(string: "")
    @State var picExist: Bool = true
  
  @EnvironmentObject var signinviewModel: AppViewModel
    
   
    init(uvm: UserViewModel, pin: MemoryPin)
    {
      self.uvm = uvm
      self.pin = pin
      

      
      self.width = Double(CGFloat(UIScreen.main.bounds.width * 0.75))
      
      
    }
  
  
  func loadImageFromFirebase()
  {
    let storageRef = Storage.storage().reference(withPath: pin.docId)
        storageRef.downloadURL { (url, error) in
               if error != nil
               {
                  self.picExist = false
                  self.imageURL = URL(string: "")
                  print((error?.localizedDescription)!)
                

                  return
        }
              self.imageURL = url!
          
          print("IMAGE URL")
          print(imageURL?.absoluteString)
            
  }
    
}


  var body: some View {
    VStack {
      
      if self.picExist == true
      {
        WebImage(url: URL(string: imageURL?.absoluteString ?? ""))
              .resizable()
              .scaledToFit()
                  .overlay(
                      RoundedRectangle(cornerRadius: 0)
                          .stroke(Color.white, lineWidth: 4)
                  )
                  .frame(width: CGFloat(width), height: CGFloat(width), alignment: .center)
                  .padding()
              .aspectRatio(contentMode: .fit)
        }
      else if self.picExist == false
      {
        Image("default")
          .resizable()
          .scaledToFit()
         .overlay(
             RoundedRectangle(cornerRadius: 0)
                 .stroke(Color.white, lineWidth: 4)
         )
         .frame(width: CGFloat(width), height: CGFloat(width), alignment: .center)
         .padding()
      }
    }
    
      VStack(alignment: .leading) {
//      VStack {
        Text("description:")
          .fontWeight(.bold)
          .padding(.leading)
          .padding(.top)
         
        Text(pin.description)
          .padding(.leading)
          .fixedSize(horizontal: false, vertical: true)
//      }.padding()
//      VStack {
        Text("date:")
          .fontWeight(.bold)
          .padding(.leading)
          .padding(.top)
        Text(pin.getDate())
          .padding(.leading)
//      }.padding()
//      VStack {
        Text("location:")
          .fontWeight(.bold)
          .padding(.leading)
          .padding(.top)
        Text(pin.locdescription)
          .padding(.leading)

//      }.padding()
//      VStack{
        Text("tag:")
          .fontWeight(.bold)
          .padding(.leading)
          .padding(.top)
        if(pin.tags.count > 0){
          Text(String(pin.tags[0].name))
            .padding(.leading)
            .foregroundColor(Color(pin.tags[0].color))
        }
        else
        {
          Text("N/A").padding(.leading)
        }
       
          
//      }.padding()
    }
    .frame(width: UIScreen.main.fixedCoordinateSpace.bounds.width, alignment: .leading)
      
    .onAppear(perform: loadImageFromFirebase)
    .navigationBarTitle(pin.title)
    .navigationBarItems(trailing:
                          NavigationLink(destination: EditPin(uvm: uvm, pin: pin).environmentObject(signinviewModel))
                          {
                            
          Image(systemName: "square.and.pencil")
      })    //.environmentObject(userPins)
  }
}
