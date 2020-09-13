//
//  config.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 9/13/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation

// MARK: - Welcome
class config: Codable {
    let code: Int?
    let message: String?
    let data: configData?
    
    init(code: Int?, message: String?, data: configData?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - DataClass
class configData: Codable {
    let shippingValue, phone, whatsapp, aboutUs: String?
    
    enum CodingKeys: String, CodingKey {
        case shippingValue = "shipping_value"
        case phone, whatsapp
        case aboutUs = "about_us"
    }
    
    init(shippingValue: String?, phone: String?, whatsapp: String?, aboutUs: String?) {
        self.shippingValue = shippingValue
        self.phone = phone
        self.whatsapp = whatsapp
        self.aboutUs = aboutUs
    }
}
