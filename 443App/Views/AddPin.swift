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
  let darkBlue = Color(red: 7/255.0, green: 30/255.0, blue: 75/255.0)

  
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
 
  @State var title: String = ""
  @State var description: String = ""
  @State var locdescription: String = ""

  
  //@State var showNewView = false
  ///
//  @State var location = Location(latitude: 40.442609, longitude: -79.945651)
//  //@State var longitude: String = long ;
//  //@State var latitude: String = lat ;
  ///
  @State var t = "";
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

    VStack {

      Form{
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
        Text("location:")
          .fontWeight(.bold)
          .padding(.leading)
        TextField("location", text: $locdescription)
          .padding(.trailing)
      }
      .padding()
        
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
    
        HStack{
          Text("select tag:")
            .fontWeight(.bold)
            .padding(.leading)
          Picker("select tag:",
            selection: $t
          ) {
              ForEach(tags){ tag in
                let tagColor = tag.color
                Text("\(tag.name)")
                  .font(.headline)
                  .foregroundColor(Color(tagColor))
                  .tag("\(tag.name)")
              }
          }.pickerStyle(WheelPickerStyle())
          .frame(height: 50)
          .frame(width: 100)
          .clipped()
          .onAppear(){
            self.tags = uvm.allTags;
            print("HERE COUNT",self.tags.count);
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
              Text("color:")
                .fontWeight(.bold)
              Picker("color:",
                selection: $c
              ) {
                ForEach(colors, id: \.self){ colorName in
                  Text(colorName)
                    .foregroundColor(Color(colorName))
                    .tag(colorName)
                  }
            }.pickerStyle(WheelPickerStyle())
            .frame(height: 50)
            .frame(width: 100)
            .clipped()
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
            

        
      }.background(darkBlue)
//form end
    }.navigationBarTitle("New Pin")
    .navigationBarItems(trailing:
Section{
      Button(action:{
        let loc = Location(latitude: Double(lat) ?? 0.0, longitude: Double(long) ?? 0.0)
        var tagArr: [Tag] = []
        var customTag = Tag(name: t, color: c);
        if(isChecked){
          tagArr.append(customTag);
        }else{
        for ctag in uvm.allTags
        {
          if((ctag.name == t))
          {
            tagArr.append(ctag)

          }
      }}
      self.uvm.savePin(title: title, description: description, locdescription: locdescription, location: loc, tags: tagArr, date: d, picture: self.image)
        print("TAGARR",tagArr)
        tagArr = []
        Journal(uvm:uvm).displayPins()
       //self.presentationMode.wrappedValue.dismiss()
        //self.showNewView = true
        
        gotoBB()
        
      })
      {
        Text("Add Pin")
      }}.disabled(t.isEmpty || title.isEmpty)
    )

  }

  // MARK: View Helper Functions
  func toggle(){
    isChecked = !isChecked
    
  }
  
  func gotoBB() {
      if let window = UIApplication.shared.windows.first {
        window.rootViewController = UIHostingController(rootView: BottomBar(userviewmodel: self.uvm))
          window.makeKeyAndVisible()
      }
  }

}
