//
//  PinDetail.swift
//  443App
//
//  Created by Simran Virdi on 11/3/21.
//

import Foundation
import SwiftUI

struct PinDetail: View {

  //@EnvironmentObject var userPins: UserPins
  @ObservedObject var uvm: UserViewModel
  var pin: MemoryPin
  var photo: Photo = Photo(pinId: "")
  var width: Double
  
 
  init(uvm: UserViewModel, pin: MemoryPin)
  {
    self.uvm = uvm
    self.pin = pin
    
    for pic in uvm.allPics
    {
      print(pic.pinId)
      if (pic.pinId == pin.docId )
      {
        
        self.photo = pic
      }
      print("IN PIN DETAIL")
      
      print(self.photo.pinId)

    }
    
    self.width = UIScreen.main.bounds.width * 0.75
    
    
  }
  


  var body: some View {
    VStack {
      photo.picture?
        .resizable()
        .scaledToFit()
        .clipShape(Circle())
        .overlay(
          Circle()
            .stroke(Color.white, lineWidth: 4)
            .shadow(radius: 10)
      )
        .frame(width: width, height: width, alignment: .center)
        .padding()
      
      HStack {
        Text("description:")
          .fontWeight(.bold)
          .padding(.leading)
        Spacer()
        Text(pin.description)
          .padding(.trailing)
      }.padding()
      HStack {
        Text("street:")
          .fontWeight(.bold)
          .padding(.leading)
        Text(pin.addressStreet)
          .padding(.trailing)
      }.padding()
      HStack {
        Text("city:")
          .fontWeight(.bold)
          .padding(.leading)
        Spacer()
        Text(pin.addressCity)
          .padding(.trailing)
      }.padding()
      HStack {
        Text("state:")
          .fontWeight(.bold)
          .padding(.leading)
        Text(pin.addressState)
          .padding(.trailing)
      }.padding()
      HStack {
        Text("zip:")
          .fontWeight(.bold)
          .padding(.leading)
        Spacer()
        Text(pin.addressZip)
          .padding(.trailing)
      }.padding()
      HStack {
        Text("tag:")
          .fontWeight(.bold)
          .padding(.leading)
        Spacer()
        if(pin.tags.count > 0){
          Text(String(pin.tags[0].name))
            .padding(.trailing)
        }
        else
        {
          Text("N/A").padding(.trailing)
        }
       
      
      }.padding()
      
     
      
      
       
    }.navigationBarTitle(pin.title)
    .navigationBarItems(trailing:
                          NavigationLink(destination: EditPin(uvm: uvm, pin: pin)) {
          Image(systemName: "square.and.pencil")
      })    //.environmentObject(userPins)
  }
}
