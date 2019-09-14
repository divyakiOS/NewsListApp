//
//  SignInViewController.swift
//  NewsApp
//
//  Created by RAC INFRA RENTAL LLP on 14/09/19.
//  Copyright © 2019 RAC INFRA RENTAL LLP. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var textFieldEidNo: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldId: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldUnifiedNumber: UITextField!
    @IBOutlet weak var textFieldMobile: UITextField!
    @IBOutlet weak var scrollBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var btnSubmit: UIButton!
    
    private let viewModel = SignInViewModel()
    private let kAlertTitle = "Alert"
    private let kErrorTitle = "Error"
    private let kNewsSegue = "NewsList"
    
    private enum AlertMessage: String {
        
        case kEid = "Eid field is mandatory!"
        case kName = "Name is mandatory!"
        case  kId = "Idbarahno is mandatory!"
        case  kEmail = "Email address is mandatory!"
        case  kUnified = "Unified number is mandatory!"
        case  kMobile = "Mobile number is mandatory!"
        case  kEmailFormat = "Email address is not valid format!"
        case  kMobileFormat = "Mobile number is not valid format!!"
        
        var description: String {
            return self.rawValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        showKeyboardSetup()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Button Action
    @IBAction func onSubmitTapped(_ sender: Any)
    {
        guard let eid = textFieldEidNo.text, viewModel.isValid(eid), let eidNumber = Int(eid) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.kEid.description)
            return
        }
        
        guard let name = textFieldName.text, viewModel.isValid(name) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.kName.description)
            return
        }
        
        guard let id = textFieldId.text, viewModel.isValid(id), let idNumber = Int(id) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.kId.description)
            return
        }
        
        guard let email = textFieldEmail.text, viewModel.isValid(email) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.kEmail.description)
            return
        }
        
        guard let unifiedNumber = textFieldUnifiedNumber.text, viewModel.isValid(unifiedNumber), let unified = Int(unifiedNumber) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.kUnified.description)
            return
        }
        
        guard let mobile = textFieldMobile.text, viewModel.isValid(mobile) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.kMobile.description)
            return
        }
        
        guard viewModel.isValidEmail(email) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.kEmailFormat.description)
            return
        }
        
        guard viewModel.isValidMobile(mobile) else {
            self.presentAlert(withTitle: kAlertTitle, message: AlertMessage.kMobileFormat.description)
            return
        }
        
        viewModel.body = ["eid" : eidNumber, "name" : name, "idbarahno" : idNumber, "emailaddress" : email, "unifiednumber" : unified, "mobileno" : mobile]
        
        self.performSegue(withIdentifier: "NewsList", sender: nil)

        Utility.shared.showActivityIndicator()
        viewModel.getSignInData { [weak self] (data) in
            
            guard let weakSelf = self else { return }
            
            DispatchQueue.main.async {
                
                Utility.shared.hideActivityIndicator()

                guard data != nil else {
                    weakSelf.presentAlert(withTitle: weakSelf.kErrorTitle, message: weakSelf.viewModel.errorMessage ?? "")
                    return
                }
                if let referenceNumber = data?.response?.referenceNo {
                    
                    UserDefaults.standard.set(referenceNumber, forKey: kReferenceNumberKey)
                    
                    weakSelf.performSegue(withIdentifier: weakSelf.kNewsSegue, sender: nil)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SignInViewController {
    
    private func showKeyboardSetup() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            scrollBottomConstraint.constant = -keyboardHeight
        }
    }
    
}

// MARK: - Keyboard Dismiss

extension SignInViewController {
    
    private func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        
        UIView.animate(withDuration: 0.30, animations: {
            self.scrollBottomConstraint.constant = 0
            self.view.endEditing(true)
        })
    }
}
