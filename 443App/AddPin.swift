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
  //intead of observedPbject try environment object - instead of observed object one that can be shared between views, and state object
  //where you save the state you call state object
  
  //at some point we have to start thinking about how do we save this data - spmeway of preserving this outside the app
  
  //need to think about saving this to firebase - what you have to save to firebase is very minimal - hugh advantage is saving to firebase is you can access it from different things
  //nature of this project is that we should use firebase

  @StateObject var viewModel: ViewModel
  //use state object for whern you are CHANGING the view MODEL
  //when you are just READING it it is an environment object
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>

  @State var title: String = "F"
  @State var description: String = "F"
  @State var street: String = "F"
  @State var city: String = "F"
  @State var state: String = "F"
  @State var zip: String = "F"
  @State var location = Location()
  @State var longitude: String = "-79.946401" ;
  @State var latitude: String = "40.442609" ;
  @State var t = "Happy";
  @State var d = Date()

  var body: some View {
    VStack {
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
        let loc = Location()
        loc.latitude = Double(latitude) ?? 0.0
        loc.longitude = Double(longitude) ?? 0.0
        let tag = Tag(name: t, color: "Yellow")
        let tagArr: [Tag] = [tag]
        print("BEFORE SAVE COUNT:")
        print(viewModel.sampleUser.allPins.count)
        self.viewModel.savePin(title: title, description: description, addressStreet: street, addressCity: city, addressState: state, addressZip: zip, location: loc, tag: tagArr, date: d)
        print("AFTER SAVE COUNT:")
        print(viewModel.sampleUser.allPins.count)
        
        self.mode.wrappedValue.dismiss()
        
      })
      {
        Text("Add Pin")
      }
    )


  }

  // MARK: View Helper Functions
 
}
