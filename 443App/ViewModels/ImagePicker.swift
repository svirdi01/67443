//
//  ImagePicker.swift
//  Contacts
//
//  Created by Simran Virdi on 10/18/21.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

  @Binding var isShown: Bool
  @Binding var image: UIImage?

  func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    
  }

  func makeCoordinator() -> ImagePickerCordinator {
    return ImagePickerCordinator(isShown: $isShown, image: $image)
  }

  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    return picker
  }
}
