//
//  ProfileHeader.swift
//  443App
//
//  Created by Claudia Osorio on 10/31/21.
//
 
import Foundation
import SwiftUI
 
struct Profile: View {
  
  func createDemoUser(){
    // Make pin by hand
    let loc = Location()
    loc.longitude = -79.946401
    loc.latitude = 40.442609
    let date1 = NSDate()
    let pin1 = MemoryPin(title:"first memory", description: "description of the memory", address: "address of the memory", location: loc, tag:[], date: date1 as Date)
    let pinArr: [MemoryPin] = [pin1]
    let happyTag = Tag(name: "Happy", color: "Yellow")
    let tagArr: [Tag] = [happyTag]
    
    // Make user by hand
    let claudiaUser = User(name: "Claudia Osorio", email: "cosorio@andrew.cmu.edu", allPins: pinArr, allTags: tagArr)
  }
  
  var body: some View {
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
 
    VStack {
      
      VStack {
        Image("profile-image")
          .resizable()
          .frame(width: 130, height: 130)
          .clipShape(Circle())
        Text("Jane Doe")
        Text("Pittsburgh, PA")
        Spacer().frame(maxHeight: 10)
        HStack {
          VStack{
            Text("First Pin Dropped")
            Text("10/3/2020")
          }
          VStack{
            Text("Latest Pin Dropped")
            Text("10/31/2021")
          }
        }.font(.system(size: 12))
        HStack {
          Text("Total Pins\n16")
              .fixedSize(horizontal: false, vertical: true)
              .multilineTextAlignment(.center)
              .padding()
              .frame(width: 115, height: 100)
              .background(Rectangle().fill(skyBlue).shadow(radius: 2))
          Text("53%\nHappy Pins")
              .fixedSize(horizontal: false, vertical: true)
              .multilineTextAlignment(.center)
              .padding()
              .frame(width: 115, height: 100)
              .background(Rectangle().fill(skyBlue).shadow(radius: 2))
        }
        HStack {
          Text("Dropped\n Most Pins\n On\n 10/3/2021")
              .fixedSize(horizontal: false, vertical: true)
              .multilineTextAlignment(.center)
              .padding()
              .frame(width: 115, height: 100)
              .background(Rectangle().fill(skyBlue).shadow(radius: 2))
          Text("Pittsburgh PA\n10")
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
