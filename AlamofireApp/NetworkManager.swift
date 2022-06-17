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
                switch response.result {
                case .success(let films):
                    completion(films)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func searchStarships(for name: String, where url: String, with completion: @escaping(Starships) -> Void) {
        let parameters: [String: String] = ["search": name]
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: Starships.self) { response in
                guard let starships = response.value else { return }
                completion(starships)
            }
    }
    
    func fetch<T: Decodable & Displayable>(_ list: [String], of: T.Type, with completion: @escaping([T]) -> Void) {
        var items: [T] = []
        let fetchGroup = DispatchGroup()
        list.forEach { (url) in
            fetchGroup.enter()
            AF.request(url).validate().responseDecodable(of: T.self) { (response) in
                if let value = response.value {
                    items.append(value)
                }
                completion(items)
                fetchGroup.leave()
            }
        }
        fetchGroup.notify(queue: .main) {
        }
    }
    
    enum Link: String {
        case films = "https://swapi.dev/api/films"
        case starships =  "https://swapi.dev/api/starships"
    }
    
    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingError
    }
}
