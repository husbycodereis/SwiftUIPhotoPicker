//
//  Picker.swift
//  SwiftUIPhotoPicker
//
//  Created by Ali Riza Reisoglu on 13.04.2022.
//

import Foundation
import UIKit

enum Picker {
    enum Source: String {
        case library, camera
    }
    //checks if there is a camera in the device
    static func checkPermissions() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            return true
        } else {
            return false
        }
    }
}
