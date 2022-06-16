//
//  NetworkManager.swift
//  AlamofireApp
//
//  Created by Максим Самусь on 16.06.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchFilms(from url: String, with completion: @escaping(Films) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: Films.self) { response in
                guard let films = response.value else { return }
                completion(films)
            }
    }
}
