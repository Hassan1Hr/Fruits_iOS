//
//  availableTime.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 9/22/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import Foundation

class availableTime: Codable {
    let code: Int?
    let message: String?
    let data: [availableTimeData]?
    
    init(code: Int?, message: String?, data: [availableTimeData]?) {
        self.code = code
        self.message = message
        self.data = data
    }
}
class availableTimeData: Codable{
    internal init(id: Int?, timeFrom: String?, timeTo: String?) {
        self.id = id
        self.timeFrom = timeFrom
        self.timeTo = timeTo
    }
    enum CodingKeys: String, CodingKey {
        case timeFrom = "time_from"
        case id
        case timeTo = "time_to"
    }
    let id: Int?
    let timeFrom,timeTo: String?
}
