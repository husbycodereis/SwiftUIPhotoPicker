//
//  ContentView.swift
//  SwiftUIPhotoPicker
//
//  Created by Ali Riza Reisoglu on 13.04.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    ZoomableScrollView {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 0,
                            maxWidth: .infinity
                        )
                    }
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.6)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.horizontal)
                }
                TextField("Image Name", text: $vm.imageName) {
                   //isEditing is a textfield default bool property to check if the text field is being used or not
                    isEditing in
                    vm.isEditing = isEditing
                }
                    .textFieldStyle(.roundedBorder)
                HStack {
                    Button {
                        if vm.selectedImage == nil {
                            vm.addMyImage(vm.imageName, image: vm.image!)
                        }
                    } label: {
                        ButtonLabel(symbolName: vm.selectedImage == nil ? "square.and.arrow.down.fill" : "square.and.arrow.up.fill", label: vm.selectedImage == nil ? "Save" : "Update")
                    }
                    //button disabled is a computed value that is created inside the ViewModel 
                        .disabled(vm.buttonDisabled)
                        .opacity(vm.buttonDisabled ? 0.6 : 1)
                    if !vm.deleteButtonIsHiddedn{
                        Button{
                            
                        }label: {
                            ButtonLabel(symbolName: "trash", label: "Delete")
                        }
                    }
                   
                }
                HStack {
                    Button {
                        vm.source = .camera
                        vm.showPhotoPicker()
                        print("adamsiiin")
                    } label: {
                        ButtonLabel(symbolName: "camera", label: "Camera")
                    }
                    Button {
                        vm.source = .library
                        vm.showPhotoPicker()
                    } label: {
                        ButtonLabel(symbolName: "photo", label: "Photos")
                    }
                }
                Spacer()
            }
            //sheet is similar to modal sheet in Flutter
            .sheet(isPresented: $vm.showPicker
                , content: {
                    ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                    //this ignores camera view safe area
                    .ignoresSafeArea()
                })
                .alert("Error", isPresented: $vm.showCameraAlert, presenting: vm.cameraError, actions: { cameraError in
                cameraError.button
            }, message: { cameraError in
                    Text(cameraError.message)
                })
                .navigationTitle("My Images")
        }
    }
}
//test

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(ViewModel())
//    }
//}
