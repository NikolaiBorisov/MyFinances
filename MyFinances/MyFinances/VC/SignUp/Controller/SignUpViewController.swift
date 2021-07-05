//
//  SignUpViewController.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 24.06.2021.
//

import UIKit
import Firebase
import InputMask
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

final class SignUpViewController: UIViewController {
  
  var reference: DatabaseReference!
  private lazy var viewMaker = SignUpViewMaker(container: self)
  var delegate: LogInOutput?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    reference = Database.database().reference()
    view.backgroundColor = .white
    setupHideKeyboardOnTaps()
    setupNavigationBar()
    viewMaker.setupLayouts()
    setupButtonAction()
    viewMaker.setupMaskForDateTextField()
  }
  
  private func upload(currentUserId: String, photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
    let ref = Storage.storage().reference().child("avatars").child(currentUserId)
    guard let imageData = viewMaker.userAvatar.image?.jpegData(compressionQuality: 0.4) else { return }
    let metadata = StorageMetadata()
    metadata.contentType = "image/jpeg"
    ref.putData(imageData, metadata: metadata) { (metadata, error) in
      guard let _ = metadata else {
        completion(.failure(error!))
        return
      }
      ref.downloadURL { (url, error) in
        guard let url = url else {
          completion(.failure(error!))
          return
        }
        completion(.success(url))
      }
    }
  }
  
  private func setupButtonAction() {
    viewMaker.createAccountButton.addTarget(self, action: #selector(onCreateButtonTapped(_:)), for: .touchUpInside)
    viewMaker.signInButton.addTarget(self, action: #selector(onSignInButtonTapped(_:)), for: .touchUpInside)
    viewMaker.userAvatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAvatarTapped)))
  }
  
  private func setupNavigationBar() {
    title = Constants.NavBarTitle.signUpTitle
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: Constants.Image.backButtonImage,
      style: .plain,
      target: self,
      action: #selector(onBackButtonTapped(_:))
    )
  }
  
  @objc private func onBackButtonTapped(_ sender: UIButton) {
    navigationController?.popToRootViewController(animated: true)
  }
  
  @objc private func onSignInButtonTapped(_ sender: UIButton) {
    navigationController?.popToRootViewController(animated: true)
  }
  
  func register(email: String?, password: String?, completion: @escaping (AuthResult) -> Void) {
    guard Validators.isFilled(
            name: viewMaker.nameTextField.text,
            email: viewMaker.emailTextField.text,
            dateOfBirth: viewMaker.dateOfBirthTextField.text,
            occupation: viewMaker.occupationTextField.text,
            password: viewMaker.passwordTextField.text) else {
      completion(.failure(AuthError.notFilled))
      return
    }
    guard let email = email, let password = password else {
      completion(.failure(AuthError.unknownError))
      return
    }
    guard Validators.isSimpleEmail(email) else {
      completion(.failure(AuthError.invalidEmail))
      return
    }
    guard Validators.isValidPassword(password) else {
      completion(.failure(AuthError.invalidPassword))
      return
    }
    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
      guard let result = result else {
        completion(.failure(error!))
        return
      }
      guard let image = self.viewMaker.userAvatar.image else { return }
      self.upload(currentUserId: result.user.uid, photo: image) { (uploadResult) in
        switch uploadResult {
        case .success(let url):
          let db = Firestore.firestore()
          guard
            let name = self.viewMaker.nameTextField.text,
            let dateOfBirth = self.viewMaker.dateOfBirthTextField.text,
            let occupation = self.viewMaker.occupationTextField.text
          else { return }
          db.collection("users").document(result.user.uid).setData([
            "name": name,
            "dateOfBirth": dateOfBirth,
            "occupation": occupation,
            "avatarURL": url.absoluteString,
            "uid": result.user.uid
          ]) { (error) in
            if let error = error {
              completion(.failure(error))
            }
            completion(.success)
          }
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
  
  @objc private func onCreateButtonTapped(_ sender: UIButton) {
    register(email: viewMaker.emailTextField.text, password: viewMaker.passwordTextField.text) { [weak self] (result) in
      switch result {
      case .success:
        self?.showAlert(with: "Success!", and: "You've been registered", completion: {
          UserDefaults.standard.isLoggedIn = false
          print("User has been successfully created")
          self?.delegate?.didFinishAuthorization()
        })
      case .failure(let error):
        self?.showAlert(with: "Error occured", and: error.localizedDescription)
      }
    }
  }
  
  @objc private func onAvatarTapped(_ sender: Any) {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.sourceType = .photoLibrary
    present(imagePickerController, animated: true, completion: nil)
  }
  
}

// MARK: - TextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
}

// MARK: - MaskedTextFieldDelegateListener
extension SignUpViewController: MaskedTextFieldDelegateListener {
  
  func textField(_ textField: UITextField, didFillMandatoryCharacters complete: Bool, didExtractValue value: String) {
    print(value)
  }
  
}

// MARK: - UIImagePickerControllerDelegate

extension SignUpViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true, completion: nil)
    guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
    viewMaker.userAvatar.image = image
  }
  
}
