//
//  LoginViewController.swift
//  
//
//  Created by Dmitry on 17/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Actions
    @IBAction func unwindToLoginVC(unwindSegue: UIStoryboardSegue) {
        print("I returned")
        dismiss(animated: true, completion: nil)
//        performSegue(withIdentifier: "unwindToLoginV", sender: nil)
    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        checkTextFields()
//        if usernameTextField.text == "",
//            passwordTextField.text == "" {
//            print("Успешный вход.")
//            performSegue(withIdentifier: "toTabBarController", sender: nil)
//        } else {
//            passwordTextField.text = ""
//            print("Неверный логин или пароль.")
//        }
    }
    @IBAction func loginVkButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toVKLoginController", sender: nil)
    }
    
    private func checkTextFields() {
        if usernameTextField.text == "",
            passwordTextField.text == "" {
            print("Успешный вход.")
            performSegue(withIdentifier: "toTabBarController", sender: nil)
//            performSegue(withIdentifier: "toVKLoginController", sender: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Incorrect login or password", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) {_ in
                self.passwordTextField.text = ""
            }
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Keyboard
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func hideKeyboard() {
        self.scrollView.endEditing(true)
    }

    //MARK: - Segues
    // Код для кнопки Log On
//     override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        switch identifier {
//        case "showMyCitiesController":
//            if usernameTextField.text == "",
//                passwordTextField.text == "" {
//                print("Успешный вход.")
//                return true
//            } else {
//                passwordTextField.text = ""
//                print("Неверный логин или пароль.")
//                return false
//            }
//        default:
//            return true
//        }
//    }
}



