//
//  MemoryPin.swift
//  443App
//
//  Created by Simran Virdi on 10/29/21.
//
import SwiftUI
class MemoryPin: Identifiable {

  var title: String
  var description: String
  var addressStreet: String
  var addressCity: String
  var addressState: String
  var addressZip: String
  var location: Location
  var tags = [Tag]()
  var memoryImage: Image?
  var date: Date
  var id: UUID
  var docId: String

  init(title: String , description: String, addressStreet: String, addressCity: String, addressState: String, addressZip: String, location: Location, tags: Array<Tag>, imagePath: String? = nil, date: Date, docId: String)
  {
    self.title = title
    self.description = description
    self.addressStreet = addressStreet
    self.addressCity = addressCity
    self.addressState = addressState
    self.addressZip = addressZip
    self.location = location
    self.tags = tags
    self.date = date
    if let image = imagePath {   // Pass the name of an xcasset image here (use this for your previews!)
      self.memoryImage = Image(image)
    }
    self.id = UUID()
    self.docId = docId;
  }
  
  func setTags(tags: [Tag])
  {
    self.tags = tags
  }
  
}
