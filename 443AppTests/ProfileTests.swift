//
//  ProfileTests.swift
//  443AppTests
//
//  Created by Claudia Osorio on 11/5/21.
//

import Foundation

import XCTest
@testable import _43App

class ProfileTests: XCTestCase {
  
  let profile = Profile(viewModel: ViewModel())
  let user = ViewModel().sampleUser
  // MARK: - Testing Repository Parsing for Swift
  
  func test_stringFromDate() {

    let todaysDate = NSDate() as Date

    XCTAssertEqual(profile.stringFromDate(date: todaysDate), "11/05/2021")
    
  }
  
  func test_mostUsedTag() {

    let tag1 = Tag(name: "happy", color: "yellow")
    let tag2 = Tag(name: "sad", color: "blue")
    let tag3 = Tag(name: "college", color: "red")


    let tags1 = [tag1, tag2, tag1, tag3]
    let tags1Ans = ["happy", "2"]
    
    let tags2 = [tag1, tag2, tag2, tag2]
    let tags2Ans = ["sad", "3"]

    
    let tags3 = [Tag]()
    let tags3Ans = ["", "0"]
    
    let tags4 = [tag3]
    let tags4Ans = ["college", "1"]

    XCTAssertEqual(profile.mostUsedTag(allTags: tags1), tags1Ans)
    XCTAssertEqual(profile.mostUsedTag(allTags: tags2), tags2Ans)
    XCTAssertEqual(profile.mostUsedTag(allTags: tags3), tags3Ans)
    XCTAssertEqual(profile.mostUsedTag(allTags: tags4), tags4Ans)

  }
  
  func test_mostPinsDate() {
    
    let loc = Location()
    loc.longitude = -79.946401
    loc.latitude = 40.442609
    let date1 = NSDate() as Date
    let dateAns = profile.stringFromDate(date: date1)
    let happyTag = Tag(name: "Happy", color: "Yellow")
    let pin1 = MemoryPin(title:"first memory", description: "description of the memory", addressStreet: "5000 Forbes Ave", addressCity: "Pittsburgh", addressState: "PA", addressZip: "15213",location: loc, tag:[happyTag], date: date1 as Date)
    let pin2 = MemoryPin(title:"second memory", description: "description of the memory", addressStreet: "5200 Forbes Ave", addressCity: "New York", addressState: "NY", addressZip: "11220",location: loc, tag:[happyTag], date: date1 as Date)
    let pinArr: [MemoryPin] = [pin1, pin2]
    let tagArr: [Tag] = [happyTag]
      
    // Make user by hand
    let claudiaUser = User(name: "Claudia Osorio", email: "cosorio@andrew.cmu.edu", allPins: pinArr, allTags: tagArr)
    let otherUser = User(name: "Name", email: "email@andrew.cmu.edu", allPins: [], allTags: [])

    XCTAssertEqual(profile.mostPinsDate(allPins: claudiaUser.allPins), dateAns)
    XCTAssertEqual(profile.mostPinsDate(allPins: otherUser.allPins), "")

  }
  
  func test_mostPinsLocation() {

    let loc = Location()
    loc.longitude = -79.946401
    loc.latitude = 40.442609
    let date1 = NSDate() as Date
    let happyTag = Tag(name: "Happy", color: "Yellow")
    let pin1 = MemoryPin(title:"first memory", description: "description of the memory", addressStreet: "5000 Forbes Ave", addressCity: "Pittsburgh", addressState: "PA", addressZip: "15213",location: loc, tag:[happyTag], date: date1 as Date)
    let pin2 = MemoryPin(title:"second memory", description: "description of the memory", addressStreet: "5200 Forbes Ave", addressCity: "New York", addressState: "NY", addressZip: "11220",location: loc, tag:[happyTag], date: date1 as Date)
    let pin3 = MemoryPin(title:"second memory", description: "description of the memory", addressStreet: "5200 Forbes Ave", addressCity: "Chicago", addressState: "NY", addressZip: "11220",location: loc, tag:[happyTag], date: date1 as Date)
    let pin4 = MemoryPin(title:"second memory", description: "description of the memory", addressStreet: "5200 Forbes Ave", addressCity: "Pittsburgh", addressState: "NY", addressZip: "11220",location: loc, tag:[happyTag], date: date1 as Date)
    let pinArr: [MemoryPin] = [pin1, pin2, pin3, pin4]
    let tagArr: [Tag] = [happyTag]
      
    // Make user by hand
    let claudiaUser = User(name: "Claudia Osorio", email: "cosorio@andrew.cmu.edu", allPins: pinArr, allTags: tagArr)
    let otherUser = User(name: "Name", email: "email@andrew.cmu.edu", allPins: [], allTags: [])


    XCTAssertEqual(profile.mostPinsLocation(allPins: claudiaUser.allPins), "Pittsburgh")
    XCTAssertEqual(profile.mostPinsLocation(allPins: otherUser.allPins), "")


  }

}
