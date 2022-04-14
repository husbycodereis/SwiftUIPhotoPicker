//
//  ViewModel.swift
//  SwiftUIPhotoPicker
//
//  Created by Ali Riza Reisoglu on 13.04.2022.
//

import SwiftUI

class ViewModel: ObservableObject{
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    
    
    // a function to check if the camera is available on the device
    func showPhotoPicker(){
        if source == .camera {
            if !Picker.checkPermissions() {
                print("There is no camera on this device")
                return
            }
        }
        showPicker = true
    }
}
