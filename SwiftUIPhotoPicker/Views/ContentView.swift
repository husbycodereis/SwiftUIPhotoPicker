//
//  ContentView.swift
//  SwiftUIPhotoPicker
//
//  Created by Ali Riza Reisoglu on 13.04.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: ViewModel
    @FocusState var nameField: Bool
    var body: some View {
        NavigationView {
            VStack {
                if !vm.isEditing{
                    imageScroll
                }
                selectedImage
                if vm.image != nil{
                  editGroup
                }
                if !vm.isEditing {
                  pickerButtons
                }
                
                Spacer()
            }
            .task {
                if FileManager().docExist(named: fileName){
                    vm.loadMyImagesJSONFile()
                }
            }
            //sheet is similar to modal sheet in Flutter
            .sheet(isPresented: $vm.showPicker
                , content: {
                    ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                    //this ignores camera view safe area
                    .ignoresSafeArea()
                })
                .alert("Error", isPresented: $vm.showFileAlert , presenting: vm.appError, actions: { cameraError in
                cameraError.button
            }, message: { cameraError in
                    Text(cameraError.message)
                })
                .navigationTitle("My Images")
            //creates a space to add widgets on the panel of the keyboard
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        HStack{
                            Spacer()
                            Button {
                                nameField = false
                            } label : {
                                Image(systemName: "keyboard.chevron.compact.down")
                            }
                        }
                    }
                }
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

