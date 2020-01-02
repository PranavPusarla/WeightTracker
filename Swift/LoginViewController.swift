//
//  LoginViewController.swift
//  HelloWorld
//
//  Created by Chandrasekhar pusarla on 12/29/19.
//  Copyright © 2019 Pranav Pusarla. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var firstNameTextField: UITextField? = nil
    var lastNameTextField: UITextField? = nil
    var firstName: String? = ""
    var lastName: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        
        let label = UILabel()
        label.text = "Login"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48.0),
            label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:-48.0)
        ])
        
        firstNameTextField =  UITextField(frame: CGRect(x: 20, y: 200, width: 300, height: 40))
        firstNameTextField!.center.x = self.view.center.x
        firstNameTextField!.placeholder = "First Name"
        firstNameTextField!.font = UIFont.systemFont(ofSize: 15)
        firstNameTextField!.borderStyle = UITextField.BorderStyle.roundedRect
        firstNameTextField!.autocorrectionType = UITextAutocorrectionType.no
        firstNameTextField!.keyboardType = UIKeyboardType.default
        firstNameTextField!.returnKeyType = UIReturnKeyType.done
        firstNameTextField!.clearButtonMode = UITextField.ViewMode.whileEditing
        firstNameTextField!.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        firstNameTextField!.delegate = self
        self.view.addSubview(firstNameTextField!)
        firstNameTextField!.delegate = self
        
        lastNameTextField = UITextField(frame: CGRect(x:20, y:300, width:300, height:40))
        lastNameTextField!.center.x = self.view.center.x
        lastNameTextField!.placeholder = "Last Name"
        lastNameTextField!.font = UIFont.systemFont(ofSize: 15)
        lastNameTextField!.borderStyle = UITextField.BorderStyle.roundedRect
        lastNameTextField!.autocorrectionType = UITextAutocorrectionType.no
        lastNameTextField!.keyboardType = UIKeyboardType.default
        lastNameTextField!.returnKeyType = UIReturnKeyType.done
        lastNameTextField!.clearButtonMode = UITextField.ViewMode.whileEditing
        lastNameTextField!.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.view.addSubview(lastNameTextField!)
        lastNameTextField!.delegate = self
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            // return NO to disallow editing.
            print("TextField should begin editing method called")
            return true
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            // became first responder
            print("TextField did begin editing method called")
        }

        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
            print("TextField should end editing method called")
            return true
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
            print("TextField did end editing method called")
        }

        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            // if implemented, called in place of textFieldDidEndEditing:
            print("TextField did end editing with reason method called")
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // return NO to not change text
            print("While entering the characters this method gets called")
            return true
        }

        func textFieldShouldClear(_ textField: UITextField) -> Bool {
            // called when clear button pressed. return NO to ignore (no notifications)
            print("TextField should clear method called")
            return true
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // called when 'return' key pressed. return NO to ignore.
            print("TextField should return method called")
            if firstNameTextField!.isFirstResponder {
                lastNameTextField!.becomeFirstResponder()
            } else {
                lastNameTextField!.resignFirstResponder()
            }
            return true
        }
        
        let loginButton = UIButton()
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 24.0
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(goHome), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loginButton)
        loginButton.setTitleColor(.gray, for: .highlighted)
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48.0),
            loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48.0),
            loginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -250.0),
            loginButton.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }
    
    @objc func goHome(sender: UIButton) {
        firstName = firstNameTextField!.text
        lastName = lastNameTextField!.text
        StatsViewController.firstName = firstName
        StatsViewController.lastName = lastName
        HomeViewController.callAPI()
        DispatchQueue.main.async {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
