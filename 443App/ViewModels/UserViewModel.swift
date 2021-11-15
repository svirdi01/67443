//
//  ReadData.swift
//  443App
//
//  Created by Simran Virdi on 11/14/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class UserViewModel: ObservableObject
{

  let db =  Firestore.firestore()
  @Published var user: User = User(name: "", email: "")
  var errorMessage = ""
  
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
          }
          catch
          {
            print(self.errorMessage)
          }
         
        }
      }
    }
        
    }
  }
  

