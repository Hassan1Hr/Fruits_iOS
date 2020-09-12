//
//  Login.swift
//  perfume
//
//  Created by Bassam Ramadan on 5/16/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
class Login: common{
    // MARK:- Outlets
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    // MARK:- ViewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "دخول"
        setupBackButtonWithDismiss()
        setupAllDelegate()
    }
    func setupAllDelegate(){
        phone.delegate = self
        password.delegate = self
        phone.text = CashedData.getUserPhone() ?? ""
    }
    @IBAction func check(_ sender: UIButton) {
        if sender.imageView?.image == #imageLiteral(resourceName: "checked") {
            sender.setImage(#imageLiteral(resourceName: "check"), for: .normal)
        }else{
            sender.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
    }
    // MARK:- Alamofire
    @IBAction func login(_ sender: UIButton) {
        self.loading()
        let url = AppDelegate.LocalUrl + "login"
        let info = [
            "phone": phone.text!,
            "password": password.text!
        ]
        
        let headers = [
            "Content-Type": "application/json" ,
            "Accept" : "application/json"
        ]
        AlamofireRequests.PostMethod( methodType: "POST", url: url, info: info, headers: headers) { (error, success , jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                       let dataRecived = try decoder.decode(registering.self, from: jsonData)
                        let user = dataRecived.data
                        CashedData.saveUserApiKey(token: user?.accessToken ?? "")
                        CashedData.saveUserUpdateKey(token: user?.accessToken ?? "")
                        CashedData.saveUserName(name: user?.name ?? "")
                        CashedData.saveUserEmail(name: user?.email ?? "")
                        CashedData.saveUserImage(name: user?.imagePath ?? "")
                        CashedData.saveUserPassword(name: self.password.text ?? "")
                        CashedData.saveUserPhone(name: user?.phone ?? "")
                        self.navigationController?.dismiss(animated: true)
                        
                        self.openMain()
                        self.stopAnimating()
                        
                    }else{
                        let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                        self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                        self.stopAnimating()
                    }
                }else{
                    let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                    self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    self.stopAnimating()
                }
            }catch {
                self.present(common.makeAlert(message: error.localizedDescription), animated: true, completion: nil)
            }
        }
    }
    // MARK:- Actions
    @IBAction func sign(_ sender: UIButton) {
        openRegisteringPage(pagTitle: "sign")
    }
    
    @IBAction func forgetPass(_ sender: UIButton) {
        openRegisteringPage(pagTitle: "forgetPass")
    }
    @IBAction func back(_ sender: UIButton) {
       openMain()
    }

}
extension Login: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.border()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.removeTextFieldBorder()
    }
}
