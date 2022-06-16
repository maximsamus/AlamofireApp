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
    
    enum Link: String {
        case films = "https://swapi.dev/api/films"
        case starships =  "https://swapi.dev/api/starships"
    }
    
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
    
//    func fetchDataWithAlamofire(_ url: String, completion: @escaping(Result<<#ModelName#>, NetworkError>) -> Void) {
//        AF.request(url)
//            .validate()
//            .responseJSON { dataResponse in
//                switch dataResponse.result {
//                case .success(let value):
//                    let <#propertyName#> = <#ModelName.funcName#>(from: value)
//                    completion(.success(courses))
//                case .failure(let error):
//                    print(error)
//                    completion(.failure(.decodingError))
//                }
//            }
//    }
//

    
    }
