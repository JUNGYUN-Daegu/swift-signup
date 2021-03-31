//
//  ViewController.swift
//  UserEnrollmentApp
//
//  Created by 조중윤 on 2021/03/29.
//

import UIKit

class SignUpViewController: UIViewController {
    let idFieldDelegate = SignUpSceneIdFieldDelegate()
    let passwordFieldDelegate = SignUpScenePasswordFieldDelegate()
    let passwordReconfirmFieldDelegate = SignUpScenePasswordReconfirmFieldDelegate()
    let nameFieldDelegate = SignUpSceneNameFieldDelegate()
    
    @IBOutlet weak var idTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    @IBOutlet weak var passwordReconfirmTextField: DesignableTextField!
    @IBOutlet weak var nameTextField: DesignableTextField!
    
    @IBOutlet weak var IDValidationResultLabel: ResultExplanationLabel!
    @IBOutlet weak var PasswordValidationResultLabel: ResultExplanationLabel!
    @IBOutlet weak var PasswordReconfirmValidationResultLabel: ResultExplanationLabel!
    @IBOutlet weak var NameValidationResultLabel: ResultExplanationLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.idTextField.delegate = idFieldDelegate
        self.passwordTextField.delegate = passwordFieldDelegate
        self.passwordReconfirmTextField.delegate = passwordReconfirmFieldDelegate
        self.nameTextField.delegate = nameFieldDelegate
        
        self.idFieldDelegate.resultNotifyingDelegate = self
        self.passwordFieldDelegate.resultNotifyingDelegate = self
        self.passwordReconfirmFieldDelegate.resultNotifyingDelegate = self
        self.nameFieldDelegate.resultNotifyingDelegate = self
    }
    
    @IBAction func NextButtonPressed(_ sender: DesignableButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "PrivateInfoViewController") as! PrivateInfoViewController
        newViewController.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(newViewController, animated: false, completion: nil)
    }
}

extension SignUpViewController: ResultNotifyingDelegate {
    func passTextFieldValue(sender: UITextFieldDelegate, value: String) {
        switch sender {
        case is SignUpScenePasswordReconfirmFieldDelegate:
            let result = value == passwordTextField.text
            PasswordReconfirmValidationResultLabel.setTextColor(isGoodExplanation: result)
            passwordReconfirmTextField.setBorderColor(wasValidInput: result)
            if result == true {
                PasswordReconfirmValidationResultLabel.text = "비밀번호가 일치합니다."
            } else {
                PasswordReconfirmValidationResultLabel.text = "비밀번호가 일치하지 않습니다."
            }
        default: return
        }
    }
    
    func passValidationResult(sender: UITextFieldDelegate, result: Bool, explanation: String) {
        switch sender {
        case is SignUpSceneIdFieldDelegate:
            IDValidationResultLabel.text = explanation
            IDValidationResultLabel.setTextColor(isGoodExplanation: result)
            idTextField.setBorderColor(wasValidInput: result)
            
        case is SignUpScenePasswordFieldDelegate:
            PasswordValidationResultLabel.text = explanation
            PasswordValidationResultLabel.setTextColor(isGoodExplanation: result)
            passwordTextField.setBorderColor(wasValidInput: result)
            
        case is SignUpSceneNameFieldDelegate:
            NameValidationResultLabel.text = explanation
            NameValidationResultLabel.setTextColor(isGoodExplanation: result)
            nameTextField.setBorderColor(wasValidInput: result)
        default: return
        }
    }
}
