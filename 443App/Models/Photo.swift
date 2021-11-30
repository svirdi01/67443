//
//  Photo.swift
//  443App
//
//  Created by Simran Virdi on 11/30/21.
//

import Foundation
import SwiftUI



class Photo: Identifiable {

  var pinId: String
  var picture: Image?

  init(pinId: String, imagePath: String? = nil)
  {
    self.pinId = pinId
    if let image = imagePath {   // Pass the name of an xcasset image here (use this for your previews!)
      self.picture = Image(image)
    }
  }

}
