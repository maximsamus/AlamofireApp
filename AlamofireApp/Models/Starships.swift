//
//  Starships.swift
//  AlamofireApp
//
//  Created by Максим Самусь on 15.06.2022.
//

struct Starships: Decodable {
    var count: Int
    var all: [Starship]
    
    enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
    }
}
