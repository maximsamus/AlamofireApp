//
//  Films.swift
//  AlamofireApp
//
//  Created by Максим Самусь on 15.06.2022.
//

struct Films: Decodable {
    let count: Int
    let all: [Film]
    
    enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
    }
}
