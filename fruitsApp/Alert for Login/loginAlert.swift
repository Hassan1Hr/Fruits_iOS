//
//  loginAlert.swift
//  perfume
//
//  Created by Bassam Ramadan on 9/11/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class loginAlert: common{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func close(){
        self.dismiss(animated: true)
    }
    @IBAction func login(){
        openRegisteringPage(pagTitle: "login")
    }
    @IBAction func signup(){
        openRegisteringPage(pagTitle: "sign")
    }
}
