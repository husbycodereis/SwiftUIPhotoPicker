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
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0,
                        maxWidth: .infinity
                    )
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.6)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.horizontal)
                }
                HStack {
                    Button {
                        vm.source = .camera
                        vm.showPhotoPicker()
                        print("adamsiiin")
                    } label: {
                        Text("Camera")
                    }
                    Button {
                        vm.source = .library
                        vm.showPhotoPicker()
                    } label: {
                        Text("Photos")
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
