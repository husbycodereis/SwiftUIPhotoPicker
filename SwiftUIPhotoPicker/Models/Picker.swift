//
//  Picker.swift
//  SwiftUIPhotoPicker
//
//  Created by Ali Riza Reisoglu on 13.04.2022.
//

import Foundation
import SwiftUI
import AVFoundation

enum Picker {
    enum Source: String {
        case library, camera
    }

    enum PickerError: Error, LocalizedError {
        case unavaliable
        case restricted
        case denied

        var errorDescription: String? {
            switch self {
            case .unavaliable:
                return NSLocalizedString("There is no available camera on this device", comment: "")
            case .restricted:
                return NSLocalizedString("You are not allowed to access media capture devices", comment: "")
            case .denied:
                return NSLocalizedString("You have specifically denied permission for media capture. Please grant access.", comment: "")
            }
        }
    }
    //checks if there is a camera in the device
    static func checkPermissions()throws {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authStatus {
            case .restricted:
                throw PickerError.restricted
            case .denied:
                throw PickerError.denied
            default:
                break
            }
        } else {
            throw PickerError.unavaliable
        }
    }
    
    struct CameraErrorType {
        let error: Picker.PickerError
        var message: String {
            error.localizedDescription
        }
        let button = Button("OK", role: .cancel){}
    }
}
