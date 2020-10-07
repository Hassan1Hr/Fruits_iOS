//
//  orders.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 9/24/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation
class orders: Codable {
    let code: Int?
    let message: String?
    let data: [orderData]?
    
    init(code: Int?, message: String?, data: [orderData]?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - Datum
class orderData: Codable {
    let id: Int?
    let userID, cartID, paymentWay, day: String?
    let timeFrom, timeTo, lat, lon: String?
    let address: String?
    let notes: String?
    let status, shippingValue: String?
    let promoCode: String?
    let promoCodeValue, totalCost, createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case cartID = "cart_id"
        case paymentWay = "payment_way"
        case day
        case timeFrom = "time_from"
        case timeTo = "time_to"
        case lat, lon, address, notes, status
        case shippingValue = "shipping_value"
        case promoCode = "promo_code"
        case promoCodeValue = "promo_code_value"
        case totalCost = "total_cost"
        case createdAt
    }
    
    init(id: Int?, userID: String?, cartID: String?, paymentWay: String?, day: String?, timeFrom: String?, timeTo: String?, lat: String?, lon: String?, address: String?, notes: String?, status: String?, shippingValue: String?, promoCode: String?, promoCodeValue: String?, totalCost: String?, createdAt: String?) {
        self.id = id
        self.userID = userID
        self.cartID = cartID
        self.paymentWay = paymentWay
        self.day = day
        self.timeFrom = timeFrom
        self.timeTo = timeTo
        self.lat = lat
        self.lon = lon
        self.address = address
        self.notes = notes
        self.status = status
        self.shippingValue = shippingValue
        self.promoCode = promoCode
        self.promoCodeValue = promoCodeValue
        self.totalCost = totalCost
        self.createdAt = createdAt
    }
}

class receipt: Codable{
    internal init(code: Int?, message: String?) {
        self.code = code
        self.message = message
    }
    
    let code: Int?
    let message: String?
    
}
