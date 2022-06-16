//
//  StartTableViewController.swift
//  AlamofireApp
//
//  Created by Максим Самусь on 15.06.2022.
//

import UIKit
import Alamofire

class StartTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var films: [Film] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        fetchFilms(url: "https://swapi.dev/api/films")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        films.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = films[indexPath.row].title
        //        content.attributedText = ""
        content.secondaryText = films[indexPath.row].releaseDate
        //        cell.textLabel?.text = String(indexPath.row)
        
        cell.contentConfiguration = content
        return cell
    }
}

extension StartTableViewController {
    
    private func fetchFilms(url: String) {
        NetworkManager.shared.fetchFilms(from: url) { films in
                            self.films = films.all
                            self.tableView.reloadData()
        }
        
        
        
    }
    
//    func fetchFilms() {
//        AF.request("https://swapi.dev/api/films")
//            .validate()
//            .responseDecodable(of: Films.self) { response in
//                guard let films = response.value else { return }
//                self.films = films.all
//                self.tableView.reloadData()
//            }
//    }
    
}
