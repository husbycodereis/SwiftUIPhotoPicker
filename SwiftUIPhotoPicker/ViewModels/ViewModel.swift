//
//  ViewModel.swift
//  SwiftUIPhotoPicker
//
//  Created by Ali Riza Reisoglu on 13.04.2022.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    @Published var showCameraAlert = false
    @Published var cameraError: Picker.CameraErrorType?
    @Published var imageName: String = ""
    @Published var isEditing = false
    @Published var selectedImage: MyImage?
    @Published var myImages: [MyImage] = []
    @Published var showFileAlert = false
    @Published var appError: MyImageError.ErrorType?
    
    init(){
        print(FileManager.docRidURL.path)
    }
    var buttonDisabled: Bool {
        imageName.isEmpty || image == nil
    }
    
    var deleteButtonIsHiddedn : Bool {
        isEditing || selectedImage == nil
    }

    // a function to check if the camera is available on the device
    func showPhotoPicker() {
        do {
            if source == .camera {
                try Picker.checkPermissions()
            }
            showPicker = true
        } catch {
            showCameraAlert = true
            cameraError = Picker.CameraErrorType(error: error as! Picker.PickerError)
        }
    }
    
    func reset(){
        image = nil
        imageName = ""
        isEditing = false
        selectedImage = nil
    }
    
    func display(_ myImage: MyImage){
        image = myImage.image
        imageName = myImage.name
        selectedImage = myImage
    }
    
    func updateSelected (){
        if let index = myImages.firstIndex(where: {$0.id == selectedImage!.id}){
            myImages[index].name = imageName
            saveMyImagesJSONFile()
            reset()
        }
    }
    
    func deleteSelected(){
        if let index = myImages.firstIndex(where: {$0.id == selectedImage!.id}){
            myImages.remove(at: index)
            saveMyImagesJSONFile()
            reset()
        }
    }
    // adds an image to the cache
    func addMyImage(_ name: String, image: UIImage){
        reset()
        print(name)
        let myImage = MyImage(name: name)
        
        do {
            try FileManager().saveImage("\(myImage.id)", image: image)
            myImages.append(myImage)
            saveMyImagesJSONFile()
        } catch  {
            showFileAlert = true
            appError = MyImageError.ErrorType(error: error as! MyImageError)
        }
    }
    
    //creates a json file to save the name and id of an image
    func saveMyImagesJSONFile(){
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(myImages)
            let jsonString = String(decoding: data, as: UTF8.self)
            reset()
            do {
                print(jsonString)
                try FileManager().saveDocument(contents: jsonString)
            } catch  {
                showFileAlert = true
                appError = MyImageError.ErrorType(error: error as! MyImageError)
            }
        } catch  {
            showFileAlert = true
            appError = MyImageError.ErrorType(error: .encodingError)
        }
    }
    
    func loadMyImagesJSONFile(){
        do {
            let data = try FileManager().readDocument()
            let decoder = JSONDecoder()
            do {
                myImages = try decoder.decode([MyImage].self, from: data)
            } catch  {
                showFileAlert = true
                appError = MyImageError.ErrorType(error: .decodingError)
            }
        } catch  {
            showFileAlert = true
            appError = MyImageError.ErrorType(error: error as! MyImageError)
        }
    }
}
