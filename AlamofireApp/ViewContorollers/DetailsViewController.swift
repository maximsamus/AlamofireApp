//
//  DetailsViewController.swift
//  AlamofireApp
//
//  Created by Максим Самусь on 16.06.2022.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var item1TitleLabel: UILabel!
    @IBOutlet weak var item1Label: UILabel!
    @IBOutlet weak var item2TitleLabel: UILabel!
    @IBOutlet weak var item2Label: UILabel!
    @IBOutlet weak var item3TitleLabel: UILabel!
    @IBOutlet weak var item3Label: UILabel!
    @IBOutlet weak var listTitleLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    
    
    var data: Displayable?
    var listData: [Displayable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        fetchList()
        listTableView.dataSource = self
    }
    
    private func commonInit() {
        guard let data = data else { return }
        
        titleLabel.text = data.titleLabelText
        subtitleLabel.text = data.subtitleLabelText
        
        item1TitleLabel.text = data.item1.label
        item1Label.text = data.item1.value
        
        item2TitleLabel.text = data.item2.label
        item2Label.text = data.item2.value
        
        item3TitleLabel.text = data.item3.label
        item3Label.text = data.item3.value
        
        listTitleLabel.text = data.listTitle
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        cell.textLabel?.text = listData[indexPath.row].titleLabelText
        return cell
    }
}
// MARK: - Fetch data

extension DetailsViewController {
    func fetchList() {
        guard let data = data else { return }
        switch data {
        case is Film:
            NetworkManager.shared.fetch(data.listItems, of: Starship.self) { data in
                self.listData = data
                self.listTableView.reloadData()
            }
        case is Starship:
            NetworkManager.shared.fetch(data.listItems, of: Film.self) { data in
                self.listData = data
                self.listTableView.reloadData()
            }
        default:
            print("Unknown type: ", String(describing: type(of: data)))
        }
    }
}

