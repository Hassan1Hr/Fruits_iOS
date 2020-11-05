//
//  Cart.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 9/13/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation

// MARK: - Welcome
class cart: Codable {
    let code: Int?
    let message: String?
    let data: cartData?
    
    init(code: Int?, message: String?, data: cartData?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - DataClass
class cartData: Codable {
    let cartID: Int?
    let totalCost: String?
    var items: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case cartID = "cart_id"
        case totalCost, items
    }
    
    init(cartID: Int?, totalCost: String?, items: [Item]?) {
        self.cartID = cartID
        self.totalCost = totalCost
        self.items = items
    }
}

// MARK: - Item
class Item: Codable {
    let id: Int?
    var weightUnit, price, quantity, totalCost: String?
    let product: product?
    
    enum CodingKeys: String, CodingKey {
        case id
        case weightUnit = "weight_unit"
        case price, quantity
        case totalCost = "total_cost"
        case product
    }
    
    init(id: Int?, weightUnit: String?, price: String?, quantity: String?, totalCost: String?, product: product?) {
        self.id = id
        self.weightUnit = weightUnit
        self.price = price
        self.quantity = quantity
        self.totalCost = totalCost
        self.product = product
    }
}
