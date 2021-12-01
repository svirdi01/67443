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
  @State private var showingSheet = true
  @State var isChecked:Bool = false

  
  @ObservedObject var uvm: UserViewModel
  //NEHAS EDITS
  var long: String
  var lat: String
  
  init(uvm: UserViewModel, long: String, lat: String)
  {
    self.uvm = uvm
    //NEHAS EDITS
    self.long=long
    self.lat=lat
  }
 
  @State var title: String = "F"
  @State var description: String = "F"
  @State var locdescription: String = "F"

  
  //@State var showNewView = false
  ///
//  @State var location = Location(latitude: 40.442609, longitude: -79.945651)
//  //@State var longitude: String = long ;
//  //@State var latitude: String = lat ;
  ///
  @State var t = "College";
  @State var d = Date()
  @State var tags = UserViewModel().allTags;
  var colors: [String] = ["blue", "black", "orange", "red", "magenta", "green", "yellow", "purple"];
  @State var c = "red";

  
  @State var showImagePicker: Bool = false
  @State var image: UIImage? = nil

    var displayImage: Image? {
      if let picture = image {
        return Image(uiImage: picture)
      } else {
        return nil
      }
    }
    
  
  var body: some View {
//    NavigationLink(
//      destination: MapPinsView(uvm:uvm),
//                isActive: $showNewView
//            ) {
//                EmptyView()
//            }.isDetailLink(false)
    VStack {
//      Text("VM Pin Count: \(userPins.allPins.count)")
//      Text("VM User Name: \(userPins.forUser.name)")
      Form{
      HStack {
        Text("title:")
          .fontWeight(.bold)
          .padding(.leading)
        TextField("title of pin", text: $title).onAppear() {
          self.tags = uvm.allTags; }
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
        Text("Location:")
          .fontWeight(.bold)
          .padding(.leading)
        TextField("location", text: $locdescription)
          .padding(.trailing)
      }
        
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
      //COMMENTED OUT LONG AND LAT THINGS
//      HStack {
//        Text("longitude:")
//          .fontWeight(.bold)
//          .padding(.leading)
//        Text(long)
//          .padding(.trailing)
//      }.padding()
//      HStack {
//        Text("latitude:")
//          .fontWeight(.bold)
//          .padding(.leading)
//        Text(lat)
//          .padding(.trailing)
//      }.padding()
      // COMMENTED OUT LONG AND LAT THINGS
    
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
        
        
        displayImage?.resizable().scaledToFit().padding()
              Button(action: {
                self.showImagePicker = true
              }) {
                Text("Add Picture")
              }.padding()
              
      }.sheet(isPresented: $showImagePicker)
      {
            PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)
            

        
      }//form end
    }.navigationBarTitle("New Pin")
    .navigationBarItems(trailing:
      Button(action:{
        let loc = Location(latitude: Double(lat) ?? 0.0, longitude: Double(long) ?? 0.0)
        var tagArr: [Tag] = []
        var customTag = Tag(name: t, color: c);
        for ctag in uvm.allTags
        {
          if((ctag.name == t) && !isChecked)
          {
            tagArr.append(ctag)

          }
          if(isChecked && ctag.name != t){
            tagArr.append(customTag);
          }
        }
      self.uvm.savePin(title: title, description: description, locdescription: locdescription, location: loc, tags: tagArr, date: d, picture: self.image)
        print("TAGARR",tagArr)
        tagArr = []
        Journal(uvm:uvm).displayPins()
       //self.presentationMode.wrappedValue.dismiss()
        //self.showNewView = true
        
      })
      {
        Text("Add Pin")
    }
    )


  }

  // MARK: View Helper Functions
  func toggle(){isChecked = !isChecked}

}
