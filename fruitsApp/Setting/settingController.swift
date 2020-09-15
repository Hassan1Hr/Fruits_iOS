//
//  SettingController.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 9/15/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class settingController: common{
    
    @IBOutlet var whats: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var aboutus: UILabel!
    
    
    @IBOutlet var isLoginStack: UIStackView!
    @IBOutlet var notLoginStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "القائمة"
        setupBackButtonWithDismiss()
        
        isLoginStack.isHidden = CashedData.getUserApiKey() == ""
        notLoginStack.isHidden = CashedData.getUserApiKey() != ""
        
        
        getConfig{
            data in
            self.whats.text = data?.whatsapp ?? ""
            self.phone.text = data?.phone ?? ""
            self.aboutus.text = data?.aboutUs ?? ""
        }
        
    }
}
