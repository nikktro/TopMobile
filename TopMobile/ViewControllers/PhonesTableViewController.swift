//
//  PhonesTableViewController.swift
//  TopMobile
//
//  Created by Nikolay Trofimov on 19.04.2022.
//

import UIKit

class PhonesTableViewController: UITableViewController {
        
    // MARK: - Private Properties
    private var phones: [Phone] = []
    private var details: [DetailResponse] = []
    
    private enum Link: String {
        case mobilespecs = "https://api-mobilespecs.azharimm.site/v2/top-by-interest"
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSpecs()
    }
    
    // MARK: - Private Methods
    private func fetchSpecs() {
        NetworkManager.shared.fetchData(url: Link.mobilespecs.rawValue, type: PhoneResponse.self) { data, error in
            
            guard let data = data else { return }
            self.phones = data.data.phones
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            self.phones.forEach {
                
                NetworkManager.shared.fetchData(url: $0.detail, type: DetailResponse.self) { data, error in
                    
                    guard let data = data else { return }
                    guard let phoneIndex = self.phones.firstIndex(where: { $0.phoneName == data.data.fullName }) else { return }
                    self.phones[phoneIndex].thumbnail = data.data.thumbnail
                    
                    DispatchQueue.main.async {
                        let indexPath = IndexPath(item: phoneIndex, section: 0)
                        self.tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                }
                
            }
        }
    }
}

// MARK: - Table view data source
extension PhonesTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phones.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "phoneList", for: indexPath) as! PhonesTableViewCell
        
        cell.configure(with: phones[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
