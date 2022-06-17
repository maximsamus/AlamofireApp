//
//  StartTableViewController.swift
//  AlamofireApp
//
//  Created by Максим Самусь on 15.06.2022.
//

import UIKit
import Alamofire

class StartTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var films: [Film] = []
    var items: [Displayable] = []
    var selectedItem: Displayable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        fetchFilms(url: NetworkManager.Link.films.rawValue)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Film", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = items[indexPath.row].titleLabelText
        content.secondaryText = items[indexPath.row].subtitleLabelText
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = items[indexPath.row]
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailsViewController else { return }
        detailVC.data = selectedItem
    }
}
// MARK: - Fetch data

extension StartTableViewController {
    
    private func fetchFilms(url: String) {
        NetworkManager.shared.fetchFilms(from: url) { films in
            self.items = films.all
            self.tableView.reloadData()
        }
    }
}
// MARK: - Search bar

extension StartTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let shipName = searchBar.text else { return }
        NetworkManager.shared.searchStarships(for: shipName, where: NetworkManager.Link.starships.rawValue) { starships in
            self.items = starships.all
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        items = films
        tableView.reloadData()
        
    }
}
