//
//  ProfileHeader.swift
//  443App
//
//  Created by Claudia Osorio on 10/31/21.
//
 
import Foundation
import SwiftUI
import Firebase
import SDWebImageSwiftUI
 
struct Profile: View {
  
  //@EnvironmentObject var userPins: UserPins
  //@EnvironmentObject var userTags: UserTags
  @ObservedObject var uvm: UserViewModel
  @State private var imageURL = URL(string: "")
  @State var picExist: Bool = true
  @EnvironmentObject var signinviewModel: AppViewModel
  let lightBlue = Color(red: 220/255.0, green: 249/255.0, blue: 243/255.0)
  
  
  init(uvm: UserViewModel)
  {
    self.uvm = uvm
    
    
  }
  
  func loadImageFromFirebase()
  {
    let storageRef = Storage.storage().reference(withPath: Auth.auth().currentUser?.uid as! String ?? "1")
    print("ID IN  PROFILE")
    print(Auth.auth().currentUser?.uid)
        storageRef.downloadURL { (url, error) in
               if error != nil
               {
                  self.picExist = false
                  self.imageURL = URL(string: "")
                  print((error?.localizedDescription)!)
                

                  return
        }
              self.imageURL = url!
          
          print("IMAGE URL")
          print(imageURL?.absoluteString)
            
  }
    
}
  
  // This is from here https://stackoverflow.com/questions/576265/convert-nsdate-to-nsstring
  func stringFromDate(date: Date) -> String {
      let formatter = DateFormatter()
      formatter.dateFormat = "MM/dd/yyyy"
      return formatter.string(from: date)
  }
  
  func mostUsedTag(allTags: [Tag]) -> [String]{
    var counts = [String: Int]()
    for tag in allTags {
      if (counts.keys.contains(tag.name)){
        counts[tag.name]! += 1
      }else{
        counts[tag.name] = 1
      }
    }
    
    var maxCount = 0;
    var maxTag = "";
    for tagName in counts.keys {
      if (counts[tagName]! > maxCount){
        maxCount = counts[tagName]!
        maxTag = tagName
      }
    }
    print("MAX COUNT:")
    print(maxCount)
    print(uvm.userPinTags.count)
    let denom = uvm.userPinTags.count;
    var percent = Double(0);
    if (uvm.userPinTags.count == 0){
      percent = Double(0);
    }
    else{
       percent = (Double(maxCount)/Double(denom)) * 100 }
    print("PERCENT")
    print(percent)
    let p = Int(percent)
    return [maxTag, String(p)]
  }
  
  func mostPinsDate(allPins: [MemoryPin]) -> String
  
  {
    print(uvm.memoryPins[0].date)
    var counts = [String: Int]()
    for pin in allPins {
      let dateString = stringFromDate(date: pin.date)
      if (counts.keys.contains(dateString)){
        counts[dateString]! += 1
      }else{
        counts[dateString] = 1
      }
    }
    var maxCount = 0;
    var maxDate = "";
    for dateString in counts.keys {
      if (counts[dateString]! > maxCount){
        maxCount = counts[dateString]!
        maxDate = dateString
      }
    }
    
    return maxDate
  }
  
  func mostPinsLocation(allPins: [MemoryPin]) -> String
  {
    var counts = [String: Int]()
    for pin in allPins {
      let city = pin.locdescription
      if (counts.keys.contains(city)){
        counts[city]! += 1
      }else{
        counts[city] = 1
      }
    }
    var maxCount = 0;
    var maxCity = "";
    for city in counts.keys {
      if (counts[city]! > maxCount){
        maxCount = counts[city]!
        maxCity = city
      }
    }
    return maxCity
  }


  var body: some View {
    

    
    let darkBlue = Color(red: 7/255.0, green: 30/255.0, blue: 75/255.0)
    let greenIsh = Color(red: 77/255.0, green: 106/255.0, blue: 83/255.0)
    let boxColor = Color(red: 220/255.0, green: 249/255.0, blue: 243/255.0)
    let newBlue = Color(red: 203/255.0, green: 247/255.0, blue: 237/255.0)
    let border = Color(red: 39/255.0, green: 44/255.0, blue: 63/255.0)
    let gradient = Gradient(colors: [newBlue, darkBlue])
    
      
    
    ZStack{
    VStack {
      Spacer()
          HStack{
            Spacer()
            VStack{
              if self.picExist == true
              {
                WebImage(url: URL(string: imageURL?.absoluteString ?? ""))
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 200, height: 200)
                  .clipShape(Circle())
                  .overlay(Circle().stroke(border, lineWidth: 5))
                  .padding(.top, 60)
                
                Text(uvm.user.name).bold()
                  .foregroundColor(.black)
  //              font(Font.custom("AlteHaasGroteskRegular", size: 18))
                }
              
              else if self.picExist == false
              {
                Image("default")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 200, height: 200)
                  .clipShape(Circle())
                  .overlay(Circle().stroke(border, lineWidth: 5))
                  .padding(.top, 60)
                
                
                Text(uvm.user.name).bold()
                  .foregroundColor(.black)
  //              font(Font.custom("AlteHaasGroteskRegular", size: 18))
              }
              
            }
          
          
            
//
//            VStack{
//              Image("lheimann")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 200, height: 200)
//                .clipShape(Circle())
//                .overlay(Circle().stroke(border, lineWidth: 5))
//                .padding(.top, 60)
//
//              Text(uvm.user.name).bold()
//                .foregroundColor(.black)
////              font(Font.custom("AlteHaasGroteskRegular", size: 18))
//            }
            Spacer()
          }

      Spacer().frame(maxHeight: 20)
          VStack{
                HStack {
                  VStack{
                    Text("First Pin Dropped")
                      .foregroundColor(.black)

                    if (uvm.memoryPins.count == 0)
                    {
                      Text("N/A")
                        .foregroundColor(.black)

                      
                    }
                    else
                    {
                      Text(stringFromDate(date: uvm.memoryPins[0].date) as String)
                        .foregroundColor(.black)
                    }
                  }
                  Text("")
                  VStack{
                    Text("Latest Pin Dropped")
                      .foregroundColor(.black)

                    if (uvm.memoryPins.count == 0)
                    {
                      Text("N/A")
                        .foregroundColor(.black)

                      
                    }
                    else
                    {
                      Text(stringFromDate(date: uvm.memoryPins[uvm.memoryPins.count-1].date) as String)
                        .foregroundColor(.black)

                    }
                  }
                }.font(.system(size: 14))
                Spacer().frame(maxHeight: 20)
              
              
                HStack {
                  
                  Spacer()
                  
                  if (uvm.memoryPins.count == 0){
                    Text("No Pins Yet")
                      .fixedSize(horizontal: false, vertical: true)
                      .multilineTextAlignment(.center)
                      .padding()
                      .frame(width: 130, height: 115)
                      .background(boxColor)
                      .foregroundColor(.black)
                      .cornerRadius(30)
                      .overlay(
                          RoundedRectangle(cornerRadius: 25).stroke(border, lineWidth: 4)
                      )
                    
                  }else{
                  Text("\(uvm.memoryPins.count) Pin(s)" as String)
                      .fixedSize(horizontal: false, vertical: true)
                      .multilineTextAlignment(.center)
                      .padding()
                      .frame(width: 130, height: 115)
                    .background(boxColor)
                    .foregroundColor(.black)
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25).stroke(border, lineWidth: 4)
                    )
                  }
                  
                  Spacer()
                  
                  if (uvm.memoryPins.count == 0 || uvm.allTags.count == 0)
                  {
                    Text("No Tags Used Yet" as String)
                      .fixedSize(horizontal: false, vertical: true)
                      .multilineTextAlignment(.center)
                      .padding()
                      .frame(width: 130, height: 115)
                      .background(boxColor)
                      .foregroundColor(.black)
                      .cornerRadius(30)
                      .overlay(
                          RoundedRectangle(cornerRadius: 25).stroke(border, lineWidth: 4)
                      )

                  } else{
                    Text("\(mostUsedTag(allTags: uvm.userPinTags)[1])% \(mostUsedTag(allTags: uvm.userPinTags)[0]) Pins" as String)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 130, height: 115)
                      .background(boxColor)
                      .foregroundColor(.black)
                      .cornerRadius(30)
                      .overlay(
                          RoundedRectangle(cornerRadius: 25).stroke(border, lineWidth: 4)
                      )
                  }
                  
                  Spacer()
                }
            Spacer().frame(maxHeight: 20)
                HStack {
                  Spacer()
                  if (uvm.memoryPins.count == 0){
                    Text("Dropped\n Most Pins\n On N/A")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 130, height: 115)
                      .background(boxColor)
                      .foregroundColor(.black)
                      .cornerRadius(30)
                      .overlay(
                          RoundedRectangle(cornerRadius: 25).stroke(border, lineWidth: 4)
                      )
                    
                  }
                  else
                  {
                    
                    Text("Dropped\n Most Pins\n On \(mostPinsDate(allPins: uvm.memoryPins))")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 130, height: 115)
                      .background(boxColor)
                      .foregroundColor(.black)
                      .cornerRadius(30)
                      .overlay(
                          RoundedRectangle(cornerRadius: 25).stroke(border, lineWidth: 4)
                      )
                  }
                  
                  Spacer()

                  if (uvm.memoryPins.count == 0){
                    Text("Dropped\n Most Pins\n In N/A" as String)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 130, height: 115)
                      .background(boxColor)
                      .foregroundColor(.black)
                      .cornerRadius(30)
                      .overlay(
                          RoundedRectangle(cornerRadius: 25).stroke(border, lineWidth: 4)
                      )
                  }
                  else
                  {
                    
                    Text("Dropped\n Most Pins\n In \(mostPinsLocation(allPins: uvm.memoryPins))" as String)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 130, height: 115)
                      .background(boxColor)
                      .foregroundColor(.black)
                      .cornerRadius(30)
                      .overlay(
                          RoundedRectangle(cornerRadius: 25).stroke(border, lineWidth: 4)
                      )
                  }
                  
                  Spacer()
                  
                 
            }
            
            Button(action: {
              self.uvm.reset()
              self.signinviewModel.signedIn = false
              
            })
            {
              Text("LOG OUT")
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.top, 9)
                .padding(.bottom, 9)
            }
            .foregroundColor(darkBlue)
            .font(Font.headline.weight(.bold))
            .background(lightBlue)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(darkBlue, lineWidth: 4)
            )
            .padding(.top)
            
            
            
         
          }
      
      
     Spacer()
      Spacer()
    

    
      

    }
    .onAppear(perform: loadImageFromFirebase)
    .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
    .edgesIgnoringSafeArea(.all)
          
        }
  }
 
  }

