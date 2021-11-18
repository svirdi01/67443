// Created for 443App on 11/4/21 
// Using Swift 5.0 
// Running on macOS 11.6
// Qapla'
//

import SwiftUI

struct MapPinsView: View {
  
  @EnvironmentObject var userPins: UserPins
  @ObservedObject var uvm: UserViewModel
  
  init(uvm: UserViewModel)
  {
    self.uvm = uvm
    
    
  }
  
  
  var body: some View {
    NavigationView {
      ZStack {
        MapView(uvm: uvm)
         PinCountWidget()
         .offset(y: -275)
        NavigationLink(destination: SetPinLocationView(uvm: uvm)) {
          Text("Create")
        }
        .offset(y: 275)

      }
      .navigationBarTitle("")
      .navigationBarHidden(true)
    }
  }
}

//struct MapPinsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapPinsView()
//    }
//}
