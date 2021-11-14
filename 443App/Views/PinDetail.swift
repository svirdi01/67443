//
//  PinDetail.swift
//  443App
//
//  Created by Simran Virdi on 11/3/21.
//

import Foundation
import SwiftUI

struct PinDetail: View {

  var pin: MemoryPin
  let width = UIScreen.main.bounds.width * 0.75

  var body: some View {
    VStack {
      HStack {
        Text("description:")
          .fontWeight(.bold)
          .padding(.leading)
        Spacer()
        Text(pin.description)
          .padding(.trailing)
      }.padding()
      HStack {
        Text("street:")
          .fontWeight(.bold)
          .padding(.leading)
        Spacer()
        Text(pin.addressStreet)
          .padding(.trailing)
      }.padding()
      Spacer()
      HStack {
        Text("city:")
          .fontWeight(.bold)
          .padding(.leading)
        Spacer()
        Text(pin.addressCity)
          .padding(.trailing)
      }.padding()
      Spacer()
      HStack {
        Text("state:")
          .fontWeight(.bold)
          .padding(.leading)
        Spacer()
        Text(pin.addressState)
          .padding(.trailing)
      }.padding()
      Spacer()
      HStack {
        Text("zip:")
          .fontWeight(.bold)
          .padding(.leading)
        Spacer()
        Text(pin.addressZip)
          .padding(.trailing)
      }.padding()
      Spacer()
      HStack {
        Text("tag:")
          .fontWeight(.bold)
          .padding(.leading)
        Spacer()
        if(pin.tags.count > 0){
          Text(String(pin.tags[0].name))
            .padding(.trailing)
        }
        Text("N/A")
          .padding(.trailing)
      }.padding()
    }.navigationBarTitle(pin.title)
    .navigationBarItems(trailing:
                          NavigationLink(destination: EditPin(pin: pin)) {
          Image(systemName: "square.and.pencil")
      })

  }
}
