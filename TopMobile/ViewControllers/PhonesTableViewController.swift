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
    private var activityIndicator: UIActivityIndicatorView?
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = showSpinner(in: tableView)
        fetchSpecs(from: Link.mobilespecs.rawValue)
    }
    
    // MARK: - Private Methods
    private func fetchSpecs(from url: String?) {
        NetworkManager.shared.fetchPhoneData(from: url) { phoneResponse in
            self.phones = phoneResponse
            self.tableView.reloadData()
            
            self.phones.forEach {
                NetworkManager.shared.fetchDetailData(from: $0.detail) { detailResponse in
                    guard let phoneIndex = self.phones.firstIndex(where: { $0.phoneName == detailResponse.fullName }) else { return }
                    self.phones[phoneIndex].thumbnail = detailResponse.thumbnail

                    let indexPath = IndexPath(item: phoneIndex, section: 0)
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                    self.activityIndicator?.stopAnimating()
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

// MARK: - ActivityIndicator
private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .gray
    activityIndicator.startAnimating()
    activityIndicator.center = view.center
    activityIndicator.hidesWhenStopped = true
    
    view.addSubview(activityIndicator)
    
    return activityIndicator
}
