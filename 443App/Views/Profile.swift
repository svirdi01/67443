//
//  ProfileHeader.swift
//  443App
//
//  Created by Claudia Osorio on 10/31/21.
//
 
import Foundation
import SwiftUI
 
struct Profile: View {
  
  @EnvironmentObject var userPins: UserPins
  
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
  
  func mostPinsDate(allPins: [MemoryPin]) -> String
  
  {
    print(userPins.allPins[0].date)
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
  
  func mostPinsLocation(allPins: [MemoryPin]) -> String
  {
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
    
    
    let maxTagLst = mostUsedTag(allTags: [Tag]())
    
    let maxTagName = ""
    let maxTagCount = 1
    let maxTagPercent = 0
    
    let darkBlue = Color(red: 7/255.0, green: 30/255.0, blue: 75/255.0)
    let greenIsh = Color(red: 77/255.0, green: 106/255.0, blue: 83/255.0)
    let boxColor = Color(red: 160/255.0, green: 186/255.0, blue: 166/255.0)
    let gradient = Gradient(colors: [greenIsh, darkBlue])
    
      
    
    ZStack{
    VStack {
      Spacer()
          HStack{
            Spacer()
            
            VStack{
              Image("lheimann")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .clipped()
                .padding(.top, 60)
              
              Text(userPins.forUser.name).bold()
            }
            Spacer()
          }

      Spacer().frame(maxHeight: 20)
          VStack{
                HStack {
                  VStack{
                    Text("First Pin Dropped")
                    if (userPins.allPins.count == 0)
                    {
                      Text("N/A")
                      
                    }
                    else
                    {
                      Text(stringFromDate(date: userPins.allPins[0].date) as String)
                    }
                  }
                  Text("")
                  VStack{
                    Text("Latest Pin Dropped")
                    if (userPins.allPins.count == 0)
                    {
                      Text("N/A")
                      
                    }
                    else
                    {
                      Text(stringFromDate(date: userPins.allPins[userPins.allPins.count-1].date) as String)
                    }
                  }
                }.font(.system(size: 12))
                Spacer().frame(maxHeight: 20)
              
              
                HStack {
                  
                  Spacer()
                  
                  if (userPins.allPins.count == 0){
                    Text("No Pins Yet")
                      .fixedSize(horizontal: false, vertical: true)
                      .multilineTextAlignment(.center)
                      .padding()
                      .frame(width: 115, height: 100)
                      .background(Rectangle().fill(boxColor).shadow(radius: 2))
                    
                  }else{
                  Text("\(userPins.allPins.count) Pin(s)" as String)
                      .fixedSize(horizontal: false, vertical: true)
                      .multilineTextAlignment(.center)
                      .padding()
                      .frame(width: 115, height: 100)
                      .background(Rectangle().fill(boxColor).shadow(radius: 2))
                  }
                  
                  Spacer()
                  
                  if (maxTagName == ""){
                    Text("No Tags Used Yet" as String)
                      .fixedSize(horizontal: false, vertical: true)
                      .multilineTextAlignment(.center)
                      .padding()
                      .frame(width: 115, height: 100)
                      .background(Rectangle().fill(boxColor).shadow(radius: 2))

                  } else{
                    Text("\(maxTagPercent)% \(maxTagName) Pins" as String)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 115, height: 100)
                        .background(Rectangle().fill(boxColor).shadow(radius: 2))
                  }
                  
                  Spacer()
                }
            Spacer().frame(maxHeight: 20)
                HStack {
                  Spacer()
                  if (userPins.allPins.count == 0){
                    Text("Dropped\n Most Pins\n On N/A")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 115, height: 100)
                        .background(Rectangle().fill(boxColor).shadow(radius: 2))
                    
                  }
                  else
                  {
                    
                    Text("Dropped\n Most Pins\n On \(mostPinsDate(allPins: userPins.allPins))")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 115, height: 100)
                        .background(Rectangle().fill(boxColor).shadow(radius: 2))
                  }
                  
                  Spacer()

                  if (userPins.allPins.count == 0){
                    Text("Dropped\n Most Pins\n In N/A" as String)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 115, height: 100)
                        .background(Rectangle().fill(boxColor).shadow(radius: 2))
                  }
                  else
                  {
                    
                    Text("Dropped\n Most Pins\n In \(mostPinsLocation(allPins: userPins.allPins))" as String)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 115, height: 100)
                        .background(Rectangle().fill(boxColor).shadow(radius: 2))
                  }
                  
                  Spacer()
            }
          }

      Spacer()
      Spacer()

        }.background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
    .edgesIgnoringSafeArea(.all)
          
        }
  }
  }


