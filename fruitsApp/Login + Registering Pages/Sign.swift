//
//  sign.swift
//  perfume
//
//  Created by Bassam Ramadan on 5/16/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
class Sign: common{
    // MARK:- Outlets
    var isProfilEditing: Bool = false
    
    
    @IBOutlet var pageTitle : UILabel!
    @IBOutlet var PageDescription : UILabel!
    
    @IBOutlet var name : UITextField!
    @IBOutlet var phone : UITextField!
    @IBOutlet var email : UITextField!
    @IBOutlet var pass : UITextField!
    @IBOutlet var configPass : UITextField!
    
    
    @IBOutlet var submit : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isProfilEditing{
            pageTitle.text = "تعديل المعلومات"
            submit.setTitle("حفظ التعديلات", for: .normal)
            PageDescription.text = "عدل معلوماتك الان"
            name.text = CashedData.getUserName() ?? ""
            email.text = CashedData.getUserEmail() ?? ""
        }
        setupAllDelegate()
        navigationItem.title = "تسجيل عضوية"
        setupBackButtonWithDismiss()
    }
    func setupAllDelegate(){
        phone.delegate = self
        name.delegate = self
        pass.delegate = self
        email.delegate = self
        configPass.delegate = self
    }
     // MARK:- Actions
    
    @IBAction func check(_ sender: UIButton) {
        if sender.imageView?.image == #imageLiteral(resourceName: "checked") {
            sender.setImage(#imageLiteral(resourceName: "check"), for: .normal)
        }else{
            sender.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true)
    }
    
     // MARK:- API
    @IBAction func sign(sender : Any){
        self.loading()
        var url = AppDelegate.LocalUrl + "signup"
        var  info = [
            "name" : name.text ?? "",
            "phone" : name.text ?? "",
            "email" : email.text ?? "",
            "password" : pass.text ?? "",
            "password_confirmation" : configPass.text ?? ""
        ]
        var headers = [
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        ]
        
        if isProfilEditing{
            url = "\(AppDelegate.LocalUrl)/edit-profile"
            info = [
                "username" : name.text ?? "",
                "email" : email.text ?? "",
                "password" : CashedData.getUserPassword() ?? "",
                "password_confirmation" : CashedData.getUserPassword() ?? "",
                "_method" : "PUT"
            ]
            headers = [
                "Accept" : "application/json",
                "Content-Type" : "application/json",
                "Authorization": "Bearer \(CashedData.getUserApiKey() ?? "")"
            ]
        }
        
        AlamofireRequests.PostMethod(methodType: "POST", url: url, info: info, headers: headers){
            (error, success , jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                        
                        let dataRecived = try decoder.decode(registering.self, from: jsonData)
                        let user = dataRecived.data
                        
                        CashedData.saveUserName(name: user?.name ?? "")
                        CashedData.saveUserEmail(name: user?.email ?? "")
                        CashedData.saveUserPassword(name: self.pass.text ?? "")
                        CashedData.saveUserImage(name: user?.imagePath ?? "")
                        
                        if self.isProfilEditing == false{
                            CashedData.saveUserApiKey(token: user?.accessToken ?? "")
                            CashedData.saveUserUpdateKey(token: user?.accessToken ?? "")
                        }
                        
                        
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
                self.stopAnimating()
            }
        }
    }
}

extension Sign: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.border()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.removeTextFieldBorder()
    }
}
