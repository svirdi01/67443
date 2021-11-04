//
//  ProfileHeader.swift
//  443App
//
//  Created by Claudia Osorio on 10/31/21.
//
 
import Foundation
import SwiftUI
 
struct Profile: View {
  //move calculations to a view model
  //observed object
  //shift formatinng and logic to viewmodel so we can bind more directly
  //use getters and setters in viewmodel to update text
  //look imto context - primary way a uiview representable object gets update that something has changed - pass reference to contexts object from map view to form viewmodel - probably function in context to be updated
  //review swift repo/contact and maybe simple browser labs
  
  var viewModel: ViewModel
  
  // ContentView initialize ProfileViewMOdel()
  // ProfileViewModel pass down
    // MapView --> CreatePinView --> viewModel.AddPin(...)
    // --> bind --> ProfileView viewModel.user.pins
    //
  
  // This is from here lol https://stackoverflow.com/questions/576265/convert-nsdate-to-nsstring idk if this is allowed
  func stringFromDate(date: Date) -> String {
      let formatter = DateFormatter()
      formatter.dateFormat = "MM/dd/yyyy"
      return formatter.string(from: date)
  }
  
  func mostUsedTag(allTags: [Tag]) -> [String]{
    var counts = [String: Int]()
    for tag in allTags {
      if (counts.keys.contains(tag.name)){
        counts[tag.name]! += 1
      }else{
        counts[tag.name] = 1
      }
    }
    
    var maxCount = 0;
    var maxTag = "";
    for tagName in counts.keys {
      if (counts[tagName]! > maxCount){
        maxCount = counts[tagName]!
        maxTag = tagName
      }
    }
    return [maxTag, String(maxCount)]
  }
  
  func mostPinsDate(allPins: [MemoryPin]) -> String {
    var counts = [String: Int]()
    for pin in allPins {
      let dateString = stringFromDate(date: pin.date)
      if (counts.keys.contains(dateString)){
        counts[dateString]! += 1
      }else{
        counts[dateString] = 1
      }
    }
    var maxCount = 0;
    var maxDate = "";
    for dateString in counts.keys {
      if (counts[dateString]! > maxCount){
        maxCount = counts[dateString]!
        maxDate = dateString
      }
    }
    return maxDate
  }
  
  func mostPinsLocation(allPins: [MemoryPin]) -> String {
    var counts = [String: Int]()
    for pin in allPins {
      let city = pin.addressCity
      if (counts.keys.contains(city)){
        counts[city]! += 1
      }else{
        counts[city] = 1
      }
    }
    var maxCount = 0;
    var maxCity = "";
    for city in counts.keys {
      if (counts[city]! > maxCount){
        maxCount = counts[city]!
        maxCity = city
      }
    }
    return maxCity
  }
  
  var body: some View {
    
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    let maxTagLst = mostUsedTag(allTags: viewModel.sampleUser.allTags)
    
    let maxTagName = ""
    let maxTagCount = 0
    let maxTagPercent = 0

    
    let firstDate = "N/A"
    let lastDate = "N/A"
    let mostPinDate = "N/A"
    let mostPinsLoc = "N/A"
    if (maxTagLst.count == 2 && viewModel.sampleUser.allPins.count != 0){
      let maxTagName = "\(maxTagLst[0])"
      let maxTagCount = Int(maxTagLst[1])
      let maxTagPercent = (maxTagCount as! Int/(viewModel.sampleUser.allPins.count)) * 100
    }
    if (viewModel.sampleUser.allPins.count > 0){
      let firstDate = stringFromDate(date: viewModel.sampleUser.allPins[0].date)
      let lastDate = stringFromDate(date: viewModel.sampleUser.allPins[viewModel.sampleUser.allPins.count-1].date)
      let mostPinDate = mostPinsDate(allPins: viewModel.sampleUser.allPins)
      let mostPinsLoc = mostPinsLocation(allPins: viewModel.sampleUser.allPins)
    }

    VStack {
      
      VStack {
        Image("lheimann")
          .resizable()
          .frame(width: 150, height: 150)
          .clipShape(Circle())
          .overlay(Circle().stroke(skyBlue, lineWidth: 5))
        Text(viewModel.sampleUser.name).bold()
        Spacer().frame(maxHeight: 20)
        HStack {
          VStack{
            Text("First Pin Dropped")
            Text(firstDate as String)
          }
          Text("")
          VStack{
            Text("Latest Pin Dropped")
            Text(lastDate as String)
          }
        }.font(.system(size: 12))
        Spacer().frame(maxHeight: 20)
        HStack {
          if (viewModel.sampleUser.allPins.count == 0){
            Text("No Pins Yet")
              .fixedSize(horizontal: false, vertical: true)
              .multilineTextAlignment(.center)
              .padding()
              .frame(width: 115, height: 100)
              .background(Rectangle().fill(skyBlue).shadow(radius: 2))
            
          }else{
          Text("\(viewModel.sampleUser.allPins.count) Pin(s)" as String)
              .fixedSize(horizontal: false, vertical: true)
              .multilineTextAlignment(.center)
              .padding()
              .frame(width: 115, height: 100)
              .background(Rectangle().fill(skyBlue).shadow(radius: 2))
          }
          
          if (maxTagName == ""){
            Text("No Tags Used Yet" as String)
              .fixedSize(horizontal: false, vertical: true)
              .multilineTextAlignment(.center)
              .padding()
              .frame(width: 115, height: 100)
              .background(Rectangle().fill(skyBlue).shadow(radius: 2))

          } else{
            Text("\(maxTagPercent)% \(maxTagName) Pins" as String)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding()
                .frame(width: 115, height: 100)
                .background(Rectangle().fill(skyBlue).shadow(radius: 2))
          }
        }
        HStack {
          Text("Dropped\n Most Pins\n On \(mostPinDate)")
              .fixedSize(horizontal: false, vertical: true)
              .multilineTextAlignment(.center)
              .padding()
              .frame(width: 115, height: 100)
              .background(Rectangle().fill(skyBlue).shadow(radius: 2))
          Text("Dropped\n Most Pins\n In \(mostPinsLoc)" as String)
              .fixedSize(horizontal: false, vertical: true)
              .multilineTextAlignment(.center)
              .padding()
              .frame(width: 115, height: 100)
              .background(Rectangle().fill(skyBlue).shadow(radius: 2))
        }
      }
    }
  }
}
