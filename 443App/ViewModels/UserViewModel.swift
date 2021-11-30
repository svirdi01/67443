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
  @Published var searchText: String = ""
  @Published var filteredmemoryPins = [MemoryPin]()
  
  var errorMessage = ""
  
  //init()
  //{
    //self.fetchUser()
    
 // }
  
  func search(searchText: String) {
    self.filteredmemoryPins = self.memoryPins.filter { pin in
      return (pin.title.lowercased().contains(searchText.lowercased())) || (pin.description.lowercased().contains(searchText.lowercased()))
    }
  }
  
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
      m.setDefaultTags(tags: self.allTags);
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
                            
                            let stamp = document.get("date") as! String
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            let d = formatter.date(from:stamp)!
                            
                            
                            let m = MemoryPin(title: document.get("title") as! String, description: document.get("description") as! String, addressStreet: document.get("addressStreet") as! String, addressCity: document.get("addressCity") as! String, addressState: document.get("addressState") as! String, addressZip: document.get("addressZip") as! String, location: loc, tags: [Tag](), date: d, docId: document.documentID)
                            
                            
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
  

  func savePin(title: String , description: String, addressStreet: String, addressCity: String, addressState: String, addressZip: String, location: Location, tags: Array<Tag>, imagePath: String? = nil, date: Date) {
    
    //let newPin = MemoryPin(title: title, description: description, addressStreet: addressStreet, addressCity: addressCity, addressState: addressState, addressZip: addressZip, location: location, tags: tags , date: date)
    
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd"
    let timestamp = format.string(from: date)
    
    
    
    var ref = self.db.collection("Users").document("1").collection("MemoryPins").addDocument( data: [
      "title": title,
      "description": description,
      "addressStreet": addressStreet,
      "addressCity": addressCity,
      "addressState": addressState,
      "addressZip" : addressZip,
      "latitude" : String(location.latitude),
      "longitude" : String(location.longitude),
      "date": timestamp
    
    ])
    
    var tempArr : [Tag] = []
    for tag in tags
    {
      
      if(!tempArr.contains(tag))
      {
        tempArr.append(tag)
        self.db.collection("Users").document("1").collection("MemoryPins").document(ref.documentID).collection("Tags").addDocument(data: [
            "name": tag.name,
            "color": tag.color
          
        ])
        
      }
      
    }
    
    
    updatePins()
    
    filteredmemoryPins = self.memoryPins
     print("Pin count now \(self.memoryPins.count)")
  }
  
  func updatePins()
  {
    self.memoryPins = [MemoryPin]()
    self.allTags = [Tag]()
    fetchUser()
  }
  
  func deletePin(docId: String)
  {

    self.db.collection("Users").document("1").collection("MemoryPins").document(docId).delete()
    {
      err in
        if let err = err {
            print("Error removing document: \(err)")
        } else {
            print("Document successfully removed!")
        }
    }
    
    updatePins()
    
  }

  func editPin(docId: String)
  {
    self.db.collection("Users").document("1").collection("MemoryPins").document(docId).delete()
    {
      err in
        if let err = err {
            print("Error removing document: \(err)")
        } else {
            print("Document successfully removed!")
        }
    }
  }
  
  
  
  
  
  }

  

