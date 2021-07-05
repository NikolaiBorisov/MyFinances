//
//  ReceiptsViewController.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 25.06.2021.
//

import UIKit
import SnapKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class ReceiptsViewController: UIViewController {
  
  var dataSource: [UIImage] = []
  private lazy var viewMaker = ReceiptsViewMaker(container: self)
  private let storage = Storage.storage()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    viewMaker.setupLayouts()
    setupCollectionView()
    viewMaker.chooseButton.addTarget(self, action: #selector(choosePhoto), for: .touchUpInside)
  }
  
  private func setupCollectionView() {
    viewMaker.collectionView.delegate = self
    viewMaker.collectionView.dataSource = self
    let nib = Constants.CollectionViewCell.nib
    viewMaker.collectionView.register(nib, forCellWithReuseIdentifier: Constants.CollectionViewCell.cellIdentifier)
  }
  
  private func upload(image: Data) {
    guard let userId = Auth.auth().currentUser?.uid else { return }
    let ref = Storage.storage().reference().child("receipts").child(userId)
    let metadata = StorageMetadata()
    metadata.contentType = "image/jpeg"
    ref.putData(image, metadata: metadata) { (metadata, error) in
      guard let _ = metadata else {
        return
      }
      ref.downloadURL { (url, error) in
        guard let url = url else {
          return
        }
      }
    }
  }

//  private func downloadReceipt() {
//    guard let userId = Auth.auth().currentUser?.uid else { return }
//    let storageRef = storage.reference(forURL: "gs://myfinances-c6468.appspot.com/receipts")
//    let isLandRef = storageRef.child(userId)
//    isLandRef.getData(maxSize: 1 * 1024 * 1024) { [weak self] (data, error) in
//      if let error = error {
//        print(error.localizedDescription)
//      } else {
//        let image = UIImage(data: data!)
//        self?.cell.checkImage.image = image
//      }
//    }
//  }
  
  @objc func choosePhoto() {
    let actionSheet = UIAlertController(
      title: nil,
      message: nil,
      preferredStyle: .actionSheet
    )
    let camera = UIAlertAction(
      title: Constants.PickerViewAlertController.cameraTitle,
      style: .default) { [weak self] _ in
      self?.chooseImagePicker(source: .camera)}
    camera.setValue(
      CATextLayerAlignmentMode.left,
      forKey: Constants.AlertKeyValue.alignmentModeKey
    )
    let photo = UIAlertAction(
      title: Constants.PickerViewAlertController.photoLibraryTitle,
      style: .default) { [weak self] _ in
      self?.chooseImagePicker(source: .photoLibrary)}
    photo.setValue(
      CATextLayerAlignmentMode.left,
      forKey: Constants.AlertKeyValue.alignmentModeKey
    )
    let cancel = UIAlertAction(
      title: Constants.PickerViewAlertController.cancelTitle,
      style: .cancel
    )
    actionSheet.addAction(camera)
    actionSheet.addAction(photo)
    actionSheet.addAction(cancel)
    
    present(actionSheet, animated: true)
    viewMaker.collectionView.reloadData()
  }
  
}

extension ReceiptsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func chooseImagePicker(source: UIImagePickerController.SourceType) {
    
    if UIImagePickerController.isSourceTypeAvailable(source) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.allowsEditing = true
      imagePicker.sourceType = source
      present(imagePicker, animated: true)
    }
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    guard let defaultImage = Constants.Image.camera else { return }
    dataSource.append((img ?? defaultImage))
    viewMaker.collectionView.reloadData()
    dismiss(animated: true)
  }
  
}

extension ReceiptsViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.CollectionViewCell.cellIdentifier,
            for: indexPath)
            as? CheckCollectionViewCell
    else { return UICollectionViewCell() }
    cell.checkImage.tag = indexPath.row
    let selectedImage = dataSource[indexPath.row]
    if dataSource.isEmpty {
      cell.checkImage.image = UIImage(named: "Photo")
    }
    cell.checkImage.image = selectedImage
    let imageData = selectedImage.jpegData(compressionQuality: 0.4)
    upload(image: imageData!)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cvRect = collectionView.frame
    return CGSize(width: cvRect.width, height: cvRect.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 2,left: 2,bottom:2,right: 2)
  }
  
}
