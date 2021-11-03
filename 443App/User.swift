//
//  User.swift
//  443App
//
//  Created by Neha Joshi on 10/29/21.
//

import Foundation


class User: ObservableObject, Identifiable {
  
  var name: String
  var email: String
  var totalPins: Int
  var locationPinNum: Int
  var pinPercentNum: Int
  var mostPinsDate: Date
  @Published var allPins = [MemoryPin]()
  var allTags = [Tag]()
  
  init(name: String , email: String, allPins : Array<MemoryPin>, allTags : Array<Tag>)
  {
    self.name = name
    self.email = email
    self.allPins = allPins
    self.allTags  = allTags
    self.totalPins  = allPins.count
    self.locationPinNum = 0
    self.pinPercentNum = 0
    self.mostPinsDate = NSDate() as Date
    
  }
  
}
