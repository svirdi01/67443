// Created for 443App on 11/10/21
// Using Swift 5.0
// Running on macOS 11.6
// Qapla'
//

import Foundation
import SwiftUI

class UserTags: ObservableObject {
  
  var forUser: User
  @Published var allTags = [Tag]()
  
  init(forUser: User, allTags: Array<Tag> = []) {
    self.forUser = forUser
    self.allTags = allTags
  }
  
  func saveTag() {
    
  }
  
  func getTags()-> [Tag]{
    return allTags
  }
  
}
