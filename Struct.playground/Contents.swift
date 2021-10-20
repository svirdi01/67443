import UIKit
import CoreLocation
import SwiftUI

struct MemoryPin
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

struct User
{
  var name: String
  var email: String
  var totalPins: Int
  var locationPinNum: Int
  var pinPercentNum: Int
  var mostPinsDate: Date
  var allPins = [MemoryPin]()
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

struct Tag
{
  var name: String
  var color: String
  
  init(name: String , color: String)
  {
    self.name = name
    self.color = color
  }
  
  
}

struct Location
{
  var latitude: CLLocationDegrees
  var longitude: CLLocationDegrees
  var locationManager = CLLocationManager()
  
  func getCurrentLocation() {
    locationManager.requestWhenInUseAuthorization()
    if CLLocationManager.locationServicesEnabled() {
      locationManager.distanceFilter = kCLDistanceFilterNone
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.startUpdatingLocation()
    }
}

}

