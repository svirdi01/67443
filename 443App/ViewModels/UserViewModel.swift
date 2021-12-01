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
  @Published var user: User = User(name: "", email: "", userID: "0")
  @Published var memoryPins = [MemoryPin]()
  @Published var allTags = [Tag(name: "College", color: "orange"),Tag(name: "School", color: "red"),Tag(name: "Birthday", color: "blue"), Tag(name: "Relationship", color: "magenta"),Tag(name: "Sports", color: "green"),
       Tag(name: "Events", color: "black"), Tag(name: "Food", color: "yellow"), Tag(name: "Travel", color: "purple")]
  @Published var userPinTags = [Tag]()
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
    let tagRef = self.db.collection("Users").document(user.userID).collection("MemoryPins").document(documentID).collection("Tags").getDocuments() {
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
          if !self.allTags.contains(t)
          {
            self.allTags.append(t)
          }
           
            self.userPinTags.append(t)            
      
    }
      for tag in self.allTags{
        print("SELF>ALLTAGS", tag.name)
      }
      for othertag in self.allTags{
        print("SELF>USRLTAGS", othertag.name)
      }
      self.bool = true;
      m.setTags(tags: tagForMem)
      self.memoryPins.append(m)
      print("ALL THE PINS")
      print(self.memoryPins.count)
      print(self.memoryPins[0])
      print("YOOOOOOO")
      print(self.bool)
  }
    }
   
    
    

  }
  
  func fetchUser(userID: String)
  {
    let docRef = db.collection("Users").document(userID)

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
            self.user.userID = document.documentID
            
            print(self.user.name)
            print(self.user.email)

            let memoryPinsRef =
              self.db.collection("Users").document(userID).collection("MemoryPins").getDocuments() { [self] (querySnapshot, err) in
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
    
    
    print(user.userID)
    
    var ref = self.db.collection("Users").document(user.userID).collection("MemoryPins").addDocument( data: [
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
      
//      if(!tempArr.contains(tag))
//      {
        tempArr.append(tag)
        self.db.collection("Users").document(user.userID).collection("MemoryPins").document(ref.documentID).collection("Tags").addDocument(data: [
            "name": tag.name,
            "color": tag.color
          
        ])
        
//      }
      
    }
    
    
    updatePins()
    
    filteredmemoryPins = self.memoryPins
    print("ALLTAGSSSS \(self.allTags.count)", self.userPinTags.count)
     print("Pin count now \(self.memoryPins.count)")
  }
  
  func updatePins()
  {
    self.memoryPins = [MemoryPin]()
    self.allTags = [Tag]()
    self.allTags = [Tag(name: "College", color: "orange"),Tag(name: "School", color: "red"),Tag(name: "Birthday", color: "blue"), Tag(name: "Relationship", color: "magenta"),Tag(name: "Sports", color: "green"),
         Tag(name: "Events", color: "black"), Tag(name: "Food", color: "yellow"), Tag(name: "Travel", color: "purple")]
    self.userPinTags = [Tag]()
    fetchUser(userID: user.userID)
  }
  
  func deletePin(docId: String)
  {

    self.db.collection("Users").document(user.userID).collection("MemoryPins").document(docId).delete()
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
    self.db.collection("Users").document(user.userID).collection("MemoryPins").document(docId).delete()
    {
      err in
        if let err = err {
            print("Error removing document: \(err)")
        } else {
            print("Document successfully removed!")
        }
    }
  }
  
  func updateTags(){
    for pin in self.memoryPins{
      self.allTags.append(pin.tags[0])
    }
  }
  
  
  
  
  
  }

  

