//
//  promoCode.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 10/4/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation


class promoCode: Codable{
    internal init(code: Int?, message: String?, data: promoCodeInfo?) {
        self.code = code
        self.message = message
        self.data = data
    }
    let code: Int?
    let message: String?
    let data: promoCodeInfo?
}
class promoCodeInfo: Codable{
    internal init(id: Int?, code: String?, value: String?, status: Bool?) {
        self.id = id
        self.code = code
        self.value = value
        self.status = status
    }
    
    let id: Int?
    let code,value: String?
    let status: Bool?
}
