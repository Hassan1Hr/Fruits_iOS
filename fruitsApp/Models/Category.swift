//
//  Category.swift
//  perfume
//
//  Created by Bassam Ramadan on 9/8/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation

// MARK: - Welcome
class category: Codable {
    let code: Int?
    let message: String?
    let data: [categoryData]?
    
    init(code: Int?, message: String?, data: [categoryData]?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - Datum
class categoryData: Codable {
    let id: Int?
    let name: String?
    let imagePath: String?
    let productsCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imagePath = "image_path"
        case productsCount = "products_count"
    }
    
    init(id: Int?, name: String?, imagePath: String?, productsCount: Int?) {
        self.id = id
        self.name = name
        self.imagePath = imagePath
        self.productsCount = productsCount
    }
}
