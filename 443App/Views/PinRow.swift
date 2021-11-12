//
//  PinRow.swift
//  443App
//
//  Created by Simran Virdi on 11/3/21.
//

import Foundation
import SwiftUI

struct PinRow: View {
  var pin: MemoryPin
    var body: some View {
      Text(pin.title).font(.headline)
  }
}
