//
//  ButtonLabel.swift
//  SwiftUIPhotoPicker
//
//  Created by Ali Riza Reisoglu on 10.05.2022.
//

import SwiftUI

struct ButtonLabel: View {
    let symbolName: String
    let label: String
    var body: some View {
        HStack {
            Image(systemName: symbolName)
            Text(label)
        }
            .font(.headline)
            .padding()
            .frame(height: 40)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
    }
}

