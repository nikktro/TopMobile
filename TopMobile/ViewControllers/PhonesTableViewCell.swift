//
//  PhonesTableViewCell.swift
//  TopMobile
//
//  Created by Nikolay Trofimov on 23.04.2022.
//

import UIKit

class PhonesTableViewCell: UITableViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet var phoneImage: UIImageView!
    @IBOutlet var phoneNameLabel: UILabel!
    @IBOutlet var hitsLabel: UILabel!
    
    // MARK: - Public Methods
    func configure(with phone: Phone) {
        phoneNameLabel.text = phone.phoneName
        hitsLabel.text = String("Score: \(phone.hits)")
    }
    
    func configure(with thumb: String) {
        guard let url = URL(string: thumb) else { return }
        guard let imageData = try? Data(contentsOf: url) else { return }
        phoneImage.image = UIImage(data: imageData)
    }
    
}
