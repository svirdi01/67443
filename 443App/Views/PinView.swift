// Created for 443App on 11/4/21 
// Using Swift 5.0 
// Running on macOS 11.6
// Qapla'
//

import SwiftUI

struct PinView: View {
  
  @EnvironmentObject var userPins: UserPins
  
    var body: some View {
      NavigationView {
        PinCountWidget()
        .navigationBarItems(trailing: Button(action: {
          userPins.setRandomPin()

        }) {
            Image(systemName: "plus")
            Text("Add")
        })
    }
  }
}

//struct PinView_Previews: PreviewProvider {
//    static var previews: some View {
//        PinView()
//    }
//}
