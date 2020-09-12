//
//  signUp.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 9/12/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation

// MARK: - Welcome
class registering: Codable {
    let code: Int?
    let message: String?
    let data: registeringData?
    
    init(code: Int?, message: String?, data: registeringData?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - DataClass
class registeringData: Codable {
    let id: Int?
    let name, email, phone: String?
    let image: String?
    let status: String?
    let firebase: String?
    let createdAt, accessToken: String?
    let imagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, image, status, firebase
        case createdAt = "created_at"
        case accessToken = "access_token"
        case imagePath = "image_path"
    }
    
    init(id: Int?, name: String?, email: String?, phone: String?, image: String?, status: String?, firebase: String?, createdAt: String?, accessToken: String?, imagePath: String?) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.image = image
        self.status = status
        self.firebase = firebase
        self.createdAt = createdAt
        self.accessToken = accessToken
        self.imagePath = imagePath
    }
}
