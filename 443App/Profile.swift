//
//  ProfileHeader.swift
//  443App
//
//  Created by Claudia Osorio on 10/31/21.
//
 
import Foundation
import SwiftUI
 
struct Profile: View {
  var viewModel = ViewModel()
  
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
    let maxTagLst = mostUsedTag(allTags: viewModel.demoUser.allTags)
    let maxTagName = ""
    let maxTagCount = 0
    let maxTagPercent = 0

    
    let firstDate = "N/A"
    let lastDate = "N/A"
    let mostPinsDate = "N/A"
    let mostPinsLoc = "N/A"
    if (maxTagLst.count == 2){
      let maxTagName = "\(maxTagLst[0])"
      let maxTagCount = maxTagLst[1]
      let maxTagPercent = (maxTagCount as! Int/(viewModel.demoUser.count)) * 100
    }
    if (viewModel.demoUser.allPins.count > 0){
      let firstDate = stringFromDate(date: viewModel.demoUser.allPins[0].date)
      let lastDate = stringFromDate(date: viewModel.demoUser.allPins[viewModel.demoUser.allPins.count-1].date)
      let mostPinsDate = mostPinsDate(allPins: viewModel.demoUser.allPins)
      let mostPinsLoc = mostPinsLocation(allPins: viewModel.demoUser.allPins)
    }

    VStack {
      
      VStack {
        Image("profile-image")
          .resizable()
          .frame(width: 130, height: 130)
          .clipShape(Circle())
        Text(viewModel.demoUser.name).bold()
        Spacer().frame(maxHeight: 10)
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
        HStack {
          if (viewModel.demoUser.allPins.count == 0){
            Text("No Pins Yet")
              .fixedSize(horizontal: false, vertical: true)
              .multilineTextAlignment(.center)
              .padding()
              .frame(width: 115, height: 100)
              .background(Rectangle().fill(skyBlue).shadow(radius: 2))
            
          }else{
          Text("\(viewModel.demoUser.allPins.count) Pin(s)" as String)
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
          Text("Dropped\n Most Pins\n On \(mostPinsDate)")
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
