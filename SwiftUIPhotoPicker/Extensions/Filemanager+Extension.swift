//
//  Filemanager+Extension.swift
//  SwiftUIPhotoPicker
//
//  Created by Ali Riza Reisoglu on 10.05.2022.
//

import UIKit

let fileName = "MyImages.json"


extension FileManager {
    static var docRidURL: URL {
        return Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    func docExist(named docName: String) -> Bool {
        fileExists(atPath: Self.docRidURL.appendingPathComponent(docName).path)
    }

    func saveDocument(contents: String) throws {
        let url = Self.docRidURL.appendingPathComponent(fileName)
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            throw MyImageError.saveError
        }
    }

    func readDocument() throws -> Data {
        let url = Self.docRidURL.appendingPathComponent(fileName)
        do {
            return try Data(contentsOf: url)
        } catch {
            throw MyImageError.readError
        }
    }

    func saveImage(_ id: String, image: UIImage) throws {
        if let data = image.jpegData(compressionQuality: 0.6) {
            let imageURL = FileManager.docRidURL.appendingPathComponent("\(id).jpg")
            do {
                try data.write(to: imageURL)
            } catch {
                throw MyImageError.saveImageError
            }
        } else {
            throw MyImageError.saveImageError
        }
    }

    func readImage(with id: UUID) throws -> UIImage {
        let imageURL = FileManager.docRidURL.appendingPathComponent("\(id).jpg")
        do {
            let imageData = try Data(contentsOf: imageURL)
            if let image = UIImage(data: imageData) {
                return image
            } else {
                throw MyImageError.readImageError
            }
        } catch {
            throw MyImageError.readImageError
        }
    }


}
