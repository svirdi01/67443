//
//  ViewController.swift
//  443App
//
//  Created by Simran Virdi on 10/20/21.
//

//
//  ViewController.swift
//  app
//
//  Created by Neha Joshi on 9/28/21.
//

import Foundation
import UIKit
class ViewController: ObservableObject
{
  let currLocation = Location()
  

  func generateTitle() -> String {
    let message = "Your car is currently at:\n(\(self.currLocation.latitude), \(self.currLocation.longitude))"
    return message
  }

  func generateMessage() -> String {
    let message = "\nWhen you want to map to this location, simply press the \"Where is my car?\" button."
    return message
  }
  
}
