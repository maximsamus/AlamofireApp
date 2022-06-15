//
//  Films.swift
//  AlamofireApp
//
//  Created by Максим Самусь on 15.06.2022.
//

import Foundation

struct Films: Decodable {
    let count: Int
    let all: [Film]
    
    enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
    }
    
    enum Link: String {
        case films = "https://swapi.dev/api/films"
        case starships =  "https://swapi.dev/api/starships"
    }
}
