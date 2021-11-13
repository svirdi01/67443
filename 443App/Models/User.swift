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
 

  
  
  init(name: String , email: String) {
    self.name = name
    self.email = email
  
  }
  
}
