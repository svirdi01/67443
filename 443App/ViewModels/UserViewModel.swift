//
//  ReadData.swift
//  443App
//
//  Created by Simran Virdi on 11/14/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import SwiftUI


class UserViewModel: ObservableObject
{

  let db =  Firestore.firestore()
  @Published var user: User = User(name: "", email: "")
  @Published var memoryPins = [MemoryPin]()
  @Published var allTags = [Tag]()
  @Published var bool = false
  
  var errorMessage = ""
  
  //init()
  //{
    //self.fetchUser()
    
 // }
  
  func fetchTagsForAMemory(documentID: String, m: MemoryPin)
  {
  
    var tagForMem = [Tag]()
    //getting tags
    let tagRef = self.db.collection("Users").document("1").collection("MemoryPins").document(documentID).collection("Tags").getDocuments() {
      (querySnapshot, err) in   if let err = err
      {
      print("Error getting documents: \(err)")
        }
    else
    {

        for tag in querySnapshot!.documents
        {
            print(tag.data())
            let t = Tag(name: tag.get("name") as! String, color: tag.get("color") as! String)
            print(t.name)
            tagForMem.append(t)
            print(tagForMem)
            self.allTags.append(t)
            
      
    }
      m.setTags(tags: tagForMem)
      self.memoryPins.append(m)
      //self.setPins(m: self.memoryPins)
      //Printing pins in here
      print("ALL THE PINS")
      print(self.memoryPins.count)
      print(self.memoryPins[0])
      self.bool = true;
      print("YOOOOOOO")
      print(self.bool)
  }
    }
   
    
    

  }
  
  func fetchUser()
  {
    let docRef = db.collection("Users").document("1")

    docRef.getDocument
    {
      document, error in
      if (error as NSError?) != nil {
        self.errorMessage = "Error getting document"
      }
      else {
        if let document = document {
          do {
            
     
            self.user.name = document.get("name") as! String
            self.user.email = document.get("email") as! String
            
            print(self.user.name)
            print(self.user.email)

            let memoryPinsRef =
              self.db.collection("Users").document("1").collection("MemoryPins").getDocuments() { [self] (querySnapshot, err) in
                      if let err = err {
                          print("Error getting documents: \(err)")
                      } else {
                          for document in querySnapshot!.documents
                          {
                            //setting location
                           let l =  document.get("latitude") as! String
                            let long = document.get("longitude") as! String
                            let loc = Location(latitude: Double(l) ?? 0.0, longitude: Double(long) ?? 0.0)
                            
                           
                            
                            //getting date
                            let stamp = document.get("date") as! Timestamp
                            let d = stamp.dateValue
                            
                            let m = MemoryPin(title: document.get("title") as! String, description: document.get("description") as! String, addressStreet: document.get("addressStreet") as! String, addressCity: document.get("addressCity") as! String, addressState: document.get("addressState") as! String, addressZip: document.get("addressZip") as! String, location: loc, tags: [Tag](), date: d())
                            
                            
                            self.fetchTagsForAMemory(documentID: document.documentID, m: m)
                         
      
                          }
                      }
              }
              
     
            //.getCollection()
            //What2Yum event
            //did a lot of 
          }
          catch
          {
            print(self.errorMessage)
          }
         
        }
      }
    }
        
    }
  
  
  
    func getPins() -> [MemoryPin]
    {
      return self.memoryPins
    }
  
  func setPins(m: [MemoryPin])
  {
    self.memoryPins = m
  }
  
  
  
  }

  

