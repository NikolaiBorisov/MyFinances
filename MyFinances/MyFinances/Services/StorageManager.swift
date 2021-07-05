//
//  StorageManager.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 29.06.2021.
//

import UIKit
import FirebaseStorage

final class StorageManager {
  
  public enum StorageErrors: Error {
    case failedToUpload
    case failedToGetDownloadUrl
  }
  
  static let shared = StorageManager()
  private let storage = Storage.storage().reference()
  
  public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
  public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
    storage.child("images/\(fileName)").putData(data, metadata: nil, completion: {metadata, error in
      guard error == nil else {
        print("Failed to upload data to firebase for picture")
        completion(.failure(StorageErrors.failedToUpload))
        return
      }
      self.storage.child("images/\(fileName)").downloadURL(completion: { url, error in
        guard let url = url else {
          print("Failed to get download Url")
          completion(.failure(StorageErrors.failedToGetDownloadUrl))
          return
        }
        let urlString = url.absoluteString
        print("Download Url returned: \(urlString)")
        completion(.success(urlString))
      })
    })
  }
  
}
