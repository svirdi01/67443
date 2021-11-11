// Created for 443App on 11/10/21 
// Using Swift 5.0 
// Running on macOS 11.6
// Qapla'
//

import SwiftUI

struct PinCountWidget: View {
  
  @EnvironmentObject var userPins: UserPins
  
    var body: some View {
      VStack {
        Text("VM Pin Count: \(userPins.allPins.count)")
        Text("last pin lat: \(Double(userPins.allPins.last?.location.latitude ?? 0.0))")
        Text("last pin lon: \(Double(userPins.allPins.last?.location.longitude ?? 0.0))")
      }
    }
}

