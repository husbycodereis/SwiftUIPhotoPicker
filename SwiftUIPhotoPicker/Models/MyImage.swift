//
//  MyImage.swift
//  SwiftUIPhotoPicker
//
//  Created by Ali Riza Reisoglu on 19.04.2022.
//

import Foundation
import UIKit

//when adding Identifiable, the id property has to be added to a struct
struct MyImage: Identifiable, Codable {
    var id = UUID()
    var name: String
    
    var image: UIImage{
        do {
            return try FileManager().readImage(with: id)
        } catch  {
            return UIImage(systemName: "photo.fill")!
        }
    }
}
