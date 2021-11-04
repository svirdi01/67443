//
//  MyCustomPointAnnotation.swift
//  443App
//
//  Created by Simran Virdi on 11/3/21.
//

import UIKit
import MapKit

class MyCustomPointAnnotation: MKPointAnnotation
{
  var pin: MemoryPin
  
    init(pin: MemoryPin)
     {
          self.pin = pin
     }
  
  
}

