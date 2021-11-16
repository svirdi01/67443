//
//  Tag.swift
//  443App
//
//  Created by Simran Virdi on 10/29/21.
//

import Foundation

class Tag: Identifiable, Equatable
{
  static func == (lhs: Tag, rhs: Tag) -> Bool
  {
    if(lhs.name == rhs.name && lhs.color == rhs.color)
    {
      return true
    }
    return false
  }
  
  
  var name: String
  var color: String
  
  init(name: String , color: String) {
    self.name = name
    self.color = color
  }
  
}
