//
//  EditPin.swift
//  443App
//
//  Created by Claudia Osorio on 11/14/21.
//
import Foundation
import SwiftUI

struct EditPin: View {
  
  @EnvironmentObject var userPins: UserPins
  @ObservedObject var uvm: UserViewModel
  var pin: MemoryPin

  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @State var title: String = ""
  @State var description: String = ""
  @State var street: String = ""
  @State var city: String = ""
  @State var state: String = "F"
  @State var zip: String = "F"
  @State var location = Location(latitude: 40.442609, longitude: -79.945651)
  @State var longitude: String = "" ;
  @State var latitude: String = "" ;
  @State var t = "";
  @State var d = Date();
  @State var tags = [Tag]();
  var colors: [String] = ["blue", "black", "orange", "red", "magenta", "green", "yellow", "purple"];
  @State var c = "";
  @State var isChecked:Bool = false



    var body: some View {
      VStack {
        Form{
        HStack {
          Text("title:")
            .fontWeight(.bold)
            .padding(.leading)
//          TextField("title of pin", text: $title)
//            .padding(.trailing)
          TextField("title of pin", text: $title).onAppear() {
            self.title = self.pin.title
            self.tags = uvm.allTags;
            self.t = String(self.pin.tags[0].name);
            self.c = String(self.pin.tags[0].color);
          }.padding(.trailing)
        }.padding()
        HStack {
          Text("description:")
            .fontWeight(.bold)
            .padding(.leading)
          TextField("description", text: $description).onAppear() {
            self.description = self.pin.description}.padding(.trailing)
        }.padding()
        HStack {
          Text("street:")
            .fontWeight(.bold)
            .padding(.leading)
          TextField("street", text: $street).onAppear() {
            self.street = self.pin.addressStreet}.padding(.trailing)
          Text("city:")
            .fontWeight(.bold)
            .padding(.leading)
          TextField("city", text: $city).onAppear() {
            self.city = self.pin.addressCity}.padding(.trailing)
        }.padding()
        HStack {
          Text("state:")
            .fontWeight(.bold)
            .padding(.leading)
          TextField("state", text: $state).onAppear() {
            self.state = self.pin.addressState}.padding(.trailing)
          Text("zip:")
            .fontWeight(.bold)
            .padding(.leading)
          TextField("zip", text: $zip).onAppear() {
            self.zip = self.pin.addressZip}.padding(.trailing)
        }.padding()
//        HStack {
//          Text("longitude:")
//            .fontWeight(.bold)
//            .padding(.leading)
//          TextField("longitude", text: $longitude).onAppear() {
//            let longVal = String(self.pin.location.longitude)
//            self.longitude = longVal}.padding(.trailing)
//        }.padding()
//        HStack {
//          Text("latitude:")
//            .fontWeight(.bold)
//            .padding(.leading)
//          TextField("latitude", text: $latitude).onAppear() {
//            let latVal = String(self.pin.location.latitude)
//            self.latitude = latVal}.padding(.trailing)
//        }.padding()
        HStack {
          Text("date:")
            .fontWeight(.bold)
            .padding(.leading)
          DatePicker(
                  "",
                  selection: $d,
                  displayedComponents: [.date]
              )
          .onAppear() {
            self.d = self.pin.date}.padding(.trailing)
        }.padding()
        
        HStack{
          Picker(
            selection: $t,
            label: Text("select tag:")
              .fontWeight(.bold)
          ) {
              ForEach(tags){ tag in
                let tagColor = tag.color
                Text("\(tag.name)")
                  .font(.headline)
                  .foregroundColor(Color(tagColor))
                  .tag("\(tag.name)")
              }
            }
      }.padding()
        
        HStack {
          Button(action: toggle){
               HStack{
                   Image(systemName: isChecked ? "checkmark.square": "square")
                   Text("Want to create a custom tag?")
               }
          }
        }
            if(isChecked){
            HStack{
              Text("name:")
                .fontWeight(.bold)
              TextField("tag", text: $t)
              
              Picker(
                selection: $c,
                label: Text("color:")
                  .fontWeight(.bold)
                ,
                content: {
                  ForEach(colors, id: \.self){ colorName in
                    Text(colorName)
                      .foregroundColor(Color(colorName))
                      .tag(colorName)
                  }
                }
              )
            }.padding()
            }
        }
      }.navigationBarTitle("Editing Pin")
      .navigationBarItems(trailing:
        Button(action:{
        
          let loc = Location(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0)
          var tagArr: [Tag] = []
          var customTag = Tag(name: t, color: c);
          if (isChecked && !(tagArr.contains(customTag))){
            tagArr.append(customTag);
          }
//          for ctag in uvm.allTags
//          {
//            if(!(isChecked) && (ctag.name != t && ctag.color != c))
//            {
//              tagArr.append(ctag)
//
//            }
//          }
        
        
          self.uvm.editPin(docId: pin.docId)
          self.uvm.savePin(title: title, description: description, addressStreet: street, addressCity: city, addressState: state, addressZip: zip, location: loc, tags: tagArr, date: d)
          
          self.presentationMode.wrappedValue.dismiss()
          Journal(uvm:uvm).displayPins()
          
        })
        {
          Text("Done")
        }
      )
      
      Button(action: {
        self.uvm.deletePin(docId: pin.docId)
        self.presentationMode.wrappedValue.dismiss()
        Journal(uvm:uvm).displayPins()


                 }) {
                     Text("Delete Pin")
                     .foregroundColor(Color.white)
                 }
                 .padding()
                 .background(Color.blue)
      
      
    
  }
  func toggle(){isChecked = !isChecked}

}
