//
//  ProfileHeader.swift
//  443App
//
//  Created by Claudia Osorio on 10/31/21.
//
 
import Foundation
import SwiftUI
 
struct Profile: View {
  let viewModel: ViewModel
  
  // This is from here lol https://stackoverflow.com/questions/576265/convert-nsdate-to-nsstring idk if this is allowed  
  func stringFromDate(date: Date) -> String {
      let formatter = DateFormatter()
      formatter.dateFormat = "MM/dd/yyyy"
      return formatter.string(from: date)
  }
  
  func createDemoUser() -> User{
    // Make pin by hand
    let loc = Location()
    loc.longitude = -79.946401
    loc.latitude = 40.442609
    let date1 = NSDate()
    let happyTag = Tag(name: "Happy", color: "Yellow")
    let pin1 = MemoryPin(title:"first memory", description: "description of the memory", addressStreet: "5000 Forbes Ave", addressCity: "Pittsburgh", addressState: "PA", addressZip: "15213",location: loc, tag:[happyTag], date: date1 as Date)
    let pinArr: [MemoryPin] = [pin1]
    let tagArr: [Tag] = [happyTag]
    
    // Make user by hand
    let claudiaUser = User(name: "Claudia Osorio", email: "cosorio@andrew.cmu.edu", allPins: pinArr, allTags: tagArr)
    
    return claudiaUser
  }
  
  func mostUsedTag(allTags: [Tag]) -> [Any]{
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
    return [maxTag, maxCount]
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
    let user = createDemoUser()
    let maxTagLst = mostUsedTag(allTags: user.allTags)
    let maxTagName = maxTagLst[0]
    let maxTagCount = maxTagLst[1]
    let maxTagPercent = (maxTagCount as! Int/(user.allPins.count)) * 100
    let firstDate = stringFromDate(date: user.allPins[0].date)
    let lastDate = stringFromDate(date: user.allPins[user.allPins.count-1].date)
    let mostPinsD = mostPinsDate(allPins: user.allPins)
    let mostPinsLoc = mostPinsLocation(allPins: user.allPins)
    
    VStack {
      
      VStack {
        Image("profile-image")
          .resizable()
          .frame(width: 130, height: 130)
          .clipShape(Circle())
        Text(user.name).bold()
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
          Text("\(user.allPins.count) Pin(s)" as String)
              .fixedSize(horizontal: false, vertical: true)
              .multilineTextAlignment(.center)
              .padding()
              .frame(width: 115, height: 100)
              .background(Rectangle().fill(skyBlue).shadow(radius: 2))
          Text("\(maxTagPercent)% \(maxTagName) Pins" as String)
              .fixedSize(horizontal: false, vertical: true)
              .multilineTextAlignment(.center)
              .padding()
              .frame(width: 115, height: 100)
              .background(Rectangle().fill(skyBlue).shadow(radius: 2))
        }
        HStack {
          Text("Dropped\n Most Pins\n On \(mostPinsD)")
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
