//
//  Place.swift
//  443App
//
//  Created by Neha Joshi on 11/30/21.
//

import Foundation
import MapKit

struct Place: Identifiable{
  var id=UUID().uuidString
  var place: CLPlacemark
  
}
