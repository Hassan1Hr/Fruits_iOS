//
//  Product.swift
//  perfume
//
//  Created by Bassam Ramadan on 9/8/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation

// MARK: - Welcome
class product: Codable {
    let code: Int?
    let message: String?
    let data: dataChild?
    
    init(code: Int?, message: String?, data: dataChild?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - DataClass
class dataChild: Codable {
    let currentPage: Int?
    let data: [products]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to, total: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
    
    init(currentPage: Int?, data: [products]?, firstPageURL: String?, from: Int?, lastPage: Int?, lastPageURL: String?, nextPageURL: String?, path: String?, perPage: Int?, prevPageURL: String?, to: Int?, total: Int?) {
        self.currentPage = currentPage
        self.data = data
        self.firstPageURL = firstPageURL
        self.from = from
        self.lastPage = lastPage
        self.lastPageURL = lastPageURL
        self.nextPageURL = nextPageURL
        self.path = path
        self.perPage = perPage
        self.prevPageURL = prevPageURL
        self.to = to
        self.total = total
    }
}

// MARK: - Datum
class products: Codable {
    let id: Int?
    let name, datumDescription: String?
    let imagePath: String?
    let category: Category?
    let weightUnits: [WeightUnit]?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case imagePath = "image_path"
        case category
        case weightUnits = "weight_units"
    }
    
    init(id: Int?, name: String?, datumDescription: String?, imagePath: String?, category: Category?, weightUnits: [WeightUnit]?) {
        self.id = id
        self.name = name
        self.datumDescription = datumDescription
        self.imagePath = imagePath
        self.category = category
        self.weightUnits = weightUnits
    }
}

// MARK: - Category
class Category: Codable {
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

// MARK: - WeightUnit
class WeightUnit: Codable {
    let id, weightID: Int?
    let weightUnit, weightPrice, startFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case weightID = "weight_id"
        case weightUnit = "weight_unit"
        case weightPrice = "weight_price"
        case startFrom = "start_from"
    }
    
    init(id: Int?, weightID: Int?, weightUnit: String?, weightPrice: String?, startFrom: String?) {
        self.id = id
        self.weightID = weightID
        self.weightUnit = weightUnit
        self.weightPrice = weightPrice
        self.startFrom = startFrom
    }
}
