//
//  ViewModel.swift
//  443App
//
//  Created by Claudia Osorio on 10/26/21.
//


import Foundation
import Photos
import SwiftUI
import UIKit
import CoreData

//WORKING ON MAKING FUNCTIONS TO SAVE PINS AND SHIT

class ViewModel: ObservableObject{
  
  
  
  @Published var sampleUser = User(name: "Larry Heimann", email: "larry@gmail.com", allPins: [], allTags:[])
  
  
  
  //@Published var sampleUser:User = createDemoUser()
  
  
  let appDelegate: AppDelegate = AppDelegate()
  
  func savePin(title: String , description: String, addressStreet: String, addressCity: String, addressState: String, addressZip: String, location: Location, tag: Array<Tag>, imagePath: String? = nil, date: Date) {
    
    let newPin = MemoryPin(title: title, description: description, addressStreet: addressStreet, addressCity: addressCity, addressState: addressState, addressZip: addressZip, location: location, tag: tag, date: date)
       
      
       
    self.sampleUser.allPins.append(newPin)
    

       }
    
  }
  
  

