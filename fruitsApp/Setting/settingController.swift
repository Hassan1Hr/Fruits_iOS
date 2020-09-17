//
//  SettingController.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 9/15/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import PopupDialog
class settingController: common{
    
    @IBOutlet var whats: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var aboutus: UILabel!
    
    
    @IBOutlet var isLoginStack: UIStackView!
    @IBOutlet var notLoginStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "القائمة"
        
        isLoginStack.isHidden = CashedData.getUserApiKey() == ""
        notLoginStack.isHidden = CashedData.getUserApiKey() != ""
        
        
        getConfig{
            data in
            self.whats.text = data?.whatsapp ?? ""
            self.phone.text = data?.phone ?? ""
            self.aboutus.text = data?.aboutUs ?? ""
        }
        
    }
    // if user is login
    @IBAction func openTheMain(){
        openMain()
    }
    @IBAction func openOrders(){
        
    }
    @IBAction func openEditInfo(){
        openRegisteringPage(pagTitle: "sign")
    }
    @IBAction func logout(){
       AdminLogout(currentController: self)
    }
    
    // if user is't login
    @IBAction func openLogin(){
        openRegisteringPage(pagTitle: "login")
    }
    @IBAction func openSign(){
        openRegisteringPage(pagTitle: "sign")
    }
    
    
    // contacts
    @IBAction func callphone(){
        CallPhone(phone: phone.text ?? "")
    }
    @IBAction func callwhats(){
        callWhats(whats: whats.text ?? "")
    }
    @IBAction func share(){
        let activityController = UIActivityViewController(activityItems: [AppDelegate.stringWithLink], applicationActivities: nil)
        activityController.completionWithItemsHandler = {(nil, completed, _, error)
            in
            if completed {
                print("completed")
            } else {
                print("canceled")
            }
        }
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [AppDelegate.stringWithLink], applicationActivities: nil)
            
            //ios > 8.0
            if ( activityVC.responds(to: #selector(getter: UIViewController.popoverPresentationController)) ) {
                activityVC.popoverPresentationController?.sourceView = super.view
            }
            self.present(activityVC, animated: true, completion: nil)
        }
        else{
            present(activityController, animated: true){
                print("presented")
            }
        }
    }
    @IBAction func contactus(){
            let loginVC = ContactUs(nibName: "Contactus", bundle: nil)
            // Create the dialog
            let popup = PopupDialog(viewController: loginVC,
                                    buttonAlignment: .horizontal,
                                    transitionStyle: .bounceDown,
                                    tapGestureDismissal: false,
                                    panGestureDismissal: false)
            present(popup, animated: true, completion: nil)
    }
}
