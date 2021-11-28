//
//  AddPin.swift
//  443App
//
//  Created by Simran Virdi on 11/1/21.
//

import Foundation
import SwiftUI
import UIKit

struct AddPin: View {

  @EnvironmentObject var userPins: UserPins
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @ObservedObject var uvm: UserViewModel
  
  init(uvm: UserViewModel)
  {
    self.uvm = uvm
  }
 
  @State var title: String = "F"
  @State var description: String = "F"
  @State var street: String = "F"
  @State var city: String = "F"
  @State var state: String = "F"
  @State var zip: String = "F"
  @State var location = Location(latitude: 40.442609, longitude: -79.945651)
  @State var longitude: String = "-79.946401" ;
  @State var latitude: String = "40.442609" ;
  @State var t = "Happy";
  @State var d = Date()

  var body: some View {
    VStack {
      Text("VM Pin Count: \(userPins.allPins.count)")
      Text("VM User Name: \(userPins.forUser.name)")
      HStack {
        Text("title:")
          .fontWeight(.bold)
          .padding(.leading)
        TextField("title of pin", text: $title)
          .padding(.trailing)
      }.padding()
      HStack {
        Text("description:")
          .fontWeight(.bold)
          .padding(.leading)
        TextField("description", text: $description)
          .padding(.trailing)
      }.padding()
      HStack {
        Text("street:")
          .fontWeight(.bold)
          .padding(.leading)
        TextField("street", text: $street)
          .padding(.trailing)
        Text("city:")
          .fontWeight(.bold)
          .padding(.leading)
        TextField("city", text: $city)
          .padding(.trailing)
      }.padding()
      HStack {
        Text("state:")
          .fontWeight(.bold)
          .padding(.leading)
        TextField("state", text: $state)
          .padding(.trailing)
        Text("zip:")
          .fontWeight(.bold)
          .padding(.leading)
        TextField("zip", text: $zip)
          .padding(.trailing)
      }.padding()
      HStack {
        Text("longitude:")
          .fontWeight(.bold)
          .padding(.leading)
        TextField("longitude", text: $longitude)
          .padding(.trailing)
      }.padding()
      HStack {
        Text("latitude:")
          .fontWeight(.bold)
          .padding(.leading)
        TextField("latitude", text: $latitude)
          .padding(.trailing)
      }.padding()
      HStack {
        Text("tag:")
          .fontWeight(.bold)
          .padding(.leading)
        TextField("tag", text: $t)
          .padding(.trailing)
      }.padding()
      HStack {
        Text("date:")
          .fontWeight(.bold)
          .padding(.leading)
        DatePicker(
                "",
                selection: $d,
                displayedComponents: [.date]
            )
      }.padding()
    }.navigationBarTitle("New Pin")
    .navigationBarItems(trailing:
      Button(action:{
        let loc = Location(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0)
        var tagArr: [Tag] = []
        for ctag in uvm.allTags
        {
          if(ctag.name == t)
          {
            tagArr.append(ctag)
            
          }
        }
        
        //CHANGE THIS 
        self.uvm.savePin(title: title, description: description, addressStreet: street, addressCity: city, addressState: state, addressZip: zip, location: loc, tags: tagArr, date: d)
        
        tagArr = []
        
        self.presentationMode.wrappedValue.dismiss()
        
      })
      {
        Text("Add Pin")
      }
    )


  }

  // MARK: View Helper Functions
 
}
