//
//  Tag.swift
//  443App
//
//  Created by Simran Virdi on 10/29/21.
//

import Foundation

class Tag: Identifiable {
  
  var name: String
  var color: String
  
  init(name: String , color: String) {
    self.name = name
    self.color = color
  }
  
}
