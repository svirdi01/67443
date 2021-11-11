//
//  User.swift
//  443App
//
//  Created by Neha Joshi on 10/29/21.
//

import Foundation
import Combine


class User: ObservableObject, Identifiable {
  
  var name: String
  var email: String
 var totalPins: Int
 var locationPinNum: Int
  var pinPercentNum: Int
  var mostPinsDate: Date

  
  
  init(name: String , email: String) {
    self.name = name
    self.email = email
    self.totalPins  = 0
   self.locationPinNum = 0
    self.pinPercentNum = 0
    self.mostPinsDate = NSDate() as Date
  }
  
}
