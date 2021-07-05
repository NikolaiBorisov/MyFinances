//
//  Constants.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 22.06.2021.
//

import UIKit

enum Constants {
  
  enum NSCoder {
    static let fatalError = "init(coder:) has not been implemented"
  }
  
  enum Image {
    static let backButtonImage = UIImage(systemName: "chevron.backward")
    static let profileImage = UIImage(systemName: "person.circle")
    static let briefcaseImage = UIImage(systemName: "briefcase")
    static let dollarsignCircle = UIImage(systemName: "dollarsign.circle")
    static let minusSignCircle = UIImage(systemName: "minus.circle")
    static let camera = UIImage(systemName: "camera")
    static let defaultAvatar = UIImage(named: "Photo")
  }
  
  enum TabBarItemTitle {
    static let profile = "Profile"
    static let balance = "Balance"
    static let incomes = "Incomes"
    static let expences = "Expences"
    static let receipts = "Receipts"
  }
  
  enum Placeholder {
    static let emailOrPhonePlaceholder = "E-mail or phone number"
    static let passwordPlaceholder = "Password"
    static let fullNamePlaceholder = "Full Name"
    static let phoneNumberPlaceholder = "Phone Number"
    static let emailAddressPlaceholder = "E-mail Address"
  }
  
  enum MFButtonType: String {
    case signIn = "Sign In"
    case signUp = "Sign Up"
    case facebookLogin = "Facebook Login"
    case logout = "Log Out"
    case createAccount = "Create account"
    case forgotPassword = "Forgot password?"
    case uploadReceipt = "Upload Receipt"
    case saveReceipt = "Save Receipt"
    case addIncome = "Add Income"
    case addExpences = "Add Expences"
    case save = "Save"
    case resetPassword = "Reset My Password"
  }
  
  enum MFLabelType: String {
    case welcomeLabel = "Welcome to MyFinances"
    case descriptionLabel = "Manage all of your finances\nin one place"
    case teamLabel = "Created by om3 team"
    case orLabel = "OR"
    case noAccount = "Don't have an account?"
    case alreadyHaveAnAccount = "Already have an account?"
    case createAccount = "Create account"
    case dateOfBirth = "Date of birth"
    case occupation = "Occupation"
    case none = ""
    case notification = "Activate Notifications"
    case notificationPlaceholder = "Push Notifications"
  }
  
  enum MFTextFieldType: String {
    case passwordPlaceholder = "Password (Min: 6 characters)"
    case fullNamePlaceholder = "Full Name"
    case phoneNumberPlaceholder = "Phone Number"
    case emailAddressPlaceholder = "E-mail"
    case dateOfBirth = "Date of Birth: dd/mm/yyyy"
    case occupation = "Occupation"
    case addTitle = "Enter the category"
    case addAmount = "Enter the amount"
    case resetPassword = "Enter your email"
  }
  
  enum FontName {
    static let avenirNextMedium = "Avenir Next Medium"
  }
  
  enum NavBarTitle {
    static let signUpTitle = "Create account"
  }
  
  enum UserCreationAlert {
    static let alertTitle = "Confirmation"
    static let alertMessage = "You've successfully created your account\nYou'll be redirected to Main Ballance Screen"
    static let actionButtonTitle = "Dismiss"
  }
  
  enum UserSignInAndCreationAlert {
    static let alertTitle = "Warning!"
    static let actionButtonTitle = "Dismiss"
  }
  
  enum NavigationItemTitle {
    static let leftNavBarItem = "Log Out"
    static let rightNavBarItem = "Add"
  }
  
  enum TableViewCell {
    static let rowHeight: CGFloat = 50.0
    static let cellIdentifier =  "cell"
  }
  
  enum CollectionViewCell {
    static let cellIdentifier =  "cell"
    static let nib = UINib(nibName: "CheckCollectionViewCell", bundle: nil)
  }
  
  enum ColorTitle {
    static let lightGray = "lightGray"
  }
  
  enum PickerViewAlertController {
    static let alertTitle = "Choose an Avatar"
    static let alertMessage = "from Source"
    static let cameraTitle = "From Camera"
    static let libraryTitle = "From Photos Library"
    static let savedPhotosTitle = "Saved Photos Album"
    static let cancelTitle = "Cancel"
    static let save = "Save"
    static let yesTitle = "Yes"
    static let imgAlertCtrlTitle = "Upload Avatar"
    static let imgAlertCtrlMessage = "from Source"
    static let imgCancelActionTitle = "Cancel"
    static let photoLibraryTitle = "Photos Library"
  }
  
  enum AlertKeyValue {
    static let alignmentModeKey = "titleTextAlignment"
  }
  
  enum TextFieldMask {
    static let dateFormat = "[00]{/}[00]{/}[0000]"
  }
  
  enum Error {
    static let emailResetError = "Please enter an email address for password reset"
    static let resetSuccessMessage = "We have just sent you a password reset email. Please check your inbox and follow the instractions to reset your password"
  }
  
}
