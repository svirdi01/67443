

//
//  PhotoCaptureView.swift
//  443App
//
//  Created by Simran Virdi on 11/30/21.
import Foundation
import SwiftUI

struct PhotoCaptureView: View {

  @Binding var showImagePicker: Bool
  @Binding var image: UIImage?

  var body: some View {
    ImagePicker(isShown: $showImagePicker, image: $image)
  }
}
