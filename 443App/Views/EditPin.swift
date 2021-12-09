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
  @State var locdescription: String = ""
  @State var location = Location(latitude: 40.442609, longitude: -79.945651)
  @State var longitude: String = "" ;
  @State var latitude: String = "" ;
  @State var t = "";
  @State var d = Date();
  @State var tags = UserViewModel().allTags;
  var colors: [String] = ["blue", "black", "orange", "red", "magenta", "green", "yellow", "purple"];
  @State var c = "";
  @State var isChecked:Bool = false
  
  @EnvironmentObject var signinviewModel: AppViewModel
  

  
  
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
//          TextField("title of pin", text: $title)
//            .padding(.trailing)
          TextField("title of pin", text: $title).onAppear() {
            self.title = self.pin.title;
            self.t = self.pin.tags[0].name;
          }.padding(.trailing)
        }.padding()
        HStack {
          Text("description:")
            .fontWeight(.bold)
            .padding(.leading)
          TextField("description", text: $description).onAppear() {
            self.description = self.pin.description
            self.longitude = String(self.pin.location.longitude)
            self.latitude = String(self.pin.location.latitude)
          }.padding(.trailing)
        }.padding()
        HStack {
          Text("location:")
            .fontWeight(.bold)
            .padding(.leading)
          TextField("location", text: $locdescription).onAppear() {
            self.locdescription = self.pin.locdescription}.padding(.trailing)
        }.padding()
//        HStack {
//          Text("longitude:")
//            .fontWeight(.bold)
//           .padding(.leading)
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
//           self.latitude = latVal}.padding(.trailing)
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
                  print("HEHEHEHHE COUNT",self.tags.count);
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
//        }

        }
      }.navigationBarTitle("Editing Pin")
      .navigationBarItems(trailing:
Section{
        Button(action:{
        
          let loc = Location(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0)
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
          print("TAGS ARRAY",tagArr)
          self.uvm.savePin(title: title, description: description, locdescription: locdescription, location: loc, tags: tagArr, date: d, picture: self.image)
          self.uvm.editPin(docId: pin.docId)

          self.presentationMode.wrappedValue.dismiss()
          Journal(uvm:uvm).displayPins()
          gotoBB()
          
        })
        {
          Text("Done")
        }
        }.disabled(t.isEmpty || title.isEmpty)
      )
      
      Button(action: {
        self.uvm.deletePin(docId: pin.docId)
        Journal(uvm:uvm).displayPins()
        
        gotoBB()

                 }) {
                     Text("Delete Pin")
                     .foregroundColor(Color.white)
                 }
                 .padding()
                 .background(Color.blue)
      
     
      
      
    
  }
  func toggle(){isChecked = !isChecked}
  
  func gotoBB() {
      if let window = UIApplication.shared.windows.first {
        window.rootViewController = UIHostingController(rootView: BottomBar(userviewmodel: self.uvm).environmentObject(signinviewModel))
          window.makeKeyAndVisible()
      }
  }
  

}
