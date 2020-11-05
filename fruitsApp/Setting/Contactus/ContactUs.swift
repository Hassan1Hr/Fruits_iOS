//
//  ContactUs.swift
//  perfume
//
//  Created by Bassam Ramadan on 4/25/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class ContactUs: common {

     // MARK:- Outlets
    @IBOutlet var name : UITextField!
    @IBOutlet var phone : UITextField!
    @IBOutlet var body : UITextView!
    
    // MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        
       Modules()
       setUserData()
    }
     // MARK:- Actions
    fileprivate func Modules(){
        name.delegate = self
        phone.delegate = self
        body.delegate = self
    }
    
    fileprivate func setUserData(){
        if CashedData.getUserApiKey() != ""{
            phone.text = CashedData.getUserPhone() ?? ""
            name.text = CashedData.getUserName() ?? ""
        }
    }
    @IBAction func close(){
        super.dismiss(animated: true)
    }
    // MARK:- Alamofire
    @IBAction func AlamofireUpload(sender: UIButton){
        self.loading()
        let url = AppDelegate.LocalUrl + "contact-us"
        let headers = ["Content-Type": "application/json" ,
                       "Accept" : "application/json",
                       "Authorization": "Bearer \(CashedData.getUserApiKey() ?? "")"
        ]
        let parameters = [
            "name": name.text!,
            "phone": phone.text!,
            "message": body.text!
            ]
        AlamofireRequests.PostMethod(methodType: "POST", url: url, info: parameters, headers: headers) {
            (error, success , jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                        self.body.text = ""
                        let alert = common.makeAlert( message: "تم الارسال بنجاح")
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                        let alert = common.makeAlert(message: dataRecived.message ?? "")
                        self.present(alert, animated: true, completion: nil)
                    }
                    self.stopAnimating()
                }else{
                    let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                    self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    self.stopAnimating()
                }
            } catch {
                let alert = common.makeAlert()
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
        }
    }

}
extension ContactUs : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.border()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.removeTextFieldBorder()
    }
}
extension ContactUs: UITextViewDelegate{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.border()
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.removeTextFieldBorder()
    }
}
