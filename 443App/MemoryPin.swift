//
//  MemoryPin.swift
//  443App
//
//  Created by Simran Virdi on 10/29/21.
//
import SwiftUI

class MemoryPin: Identifiable
{
  
  var title: String
  var description: String
  var address: String
  var location: Location
  var tags = [Tag]()
  var memoryImage : Image?
  var date : Date

  init(title: String , description: String, address: String, location: Location, tag: Array<Tag>, imagePath: String? = nil, date: Date)
  {
    self.title = title
    self.description = description
    self.address = address
    self.location = location
    self.tags = tag
    self.date = date
    if let image = imagePath {   // Pass the name of an xcasset image here (use this for your previews!)
      self.memoryImage = Image(image)
    }
  }
  
}
