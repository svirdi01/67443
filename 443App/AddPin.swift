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

  var viewModel: ViewModel
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>

  @State var title: String = ""
  @State var description: String = ""
  @State var street: String = ""
  @State var city: String = ""
  @State var state: String = ""
  @State var zip: String = ""
  @State var location = Location()
  @State var longitude: String = "" ;
  @State var latitude: String = "" ;
  @State var t = "";
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
        self.viewModel.savePin(title: title, description: description, addressStreet: street, addressCity: city, addressState: state, addressZip: zip, location: loc, tag: tagArr, date: d)
        self.mode.wrappedValue.dismiss()
        
      })
      {
        Text("Add Pin")
      }
    )


  }

  // MARK: View Helper Functions
 
}
