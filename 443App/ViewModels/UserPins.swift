// Created for 443App on 11/10/21 
// Using Swift 5.0 
// Running on macOS 11.6
// Qapla'
//

import Foundation
import SwiftUI

class UserPins: ObservableObject {
  
  var forUser: User
  @Published var allPins = [MemoryPin]()
  
  init(forUser: User, allPins: Array<MemoryPin> = []) {
    self.forUser = forUser
    self.allPins = allPins
  }
  
  func savePin(title: String , description: String, addressStreet: String, addressCity: String, addressState: String, addressZip: String, location: Location, tags: Array<Tag>, imagePath: String? = nil, date: Date) {
    
    let newPin = MemoryPin(title: title, description: description, addressStreet: addressStreet, addressCity: addressCity, addressState: addressState, addressZip: addressZip, location: location, tags: [], date: date)
    
    self.allPins.append(newPin)
     print("Pin count now \(self.allPins.count)")
  }
  
  func getPins()-> [MemoryPin]{
    return allPins
  }
  
  // This method is just for demo purposes; has no use in production
  func setRandomPin() {
    let vlat = Double(Int.random(in: 1..<100))/1500.0
    let vlon = Double(Int.random(in: 1..<100))/1500.0

    let tempLatitude = 40.444176 + vlat
    let tempLongitude = -79.945551 + vlon
    
    let location = Location(latitude: tempLatitude, longitude: tempLongitude)
    print(location.latitude)
    print(location.longitude)
    let tag = Tag(name: "Fred", color: "Green")
    let tagArr: [Tag] = [tag]
    let PinTitle = "Mem#"+"\(self.allPins.count)"
    self.savePin(title: PinTitle, description: "description", addressStreet: "street", addressCity: "city", addressState: "PA", addressZip: "15213", location: location, tags: tagArr, date: Date())
  }
}
