//
//  NetworkManager.swift
//  TopMobile
//
//  Created by Nikolay Trofimov on 23.04.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchPhoneData(from url: String?, completion: @escaping([Phone]) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL)?.setScheme("https") else { return }
        
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                    
                case .success(let value):
                    guard let phones = Phone.getPhones(from: value) else { return }
                    DispatchQueue.main.async {
                        completion(phones)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func fetchDetailData(from url: String?, completion: @escaping(PhoneDetail) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL)?.setScheme("https") else { return }
        
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                    
                case .success(let value):
                    guard let phoneDetail = PhoneDetail.getPhoneDetail(from: value) else { return }
                    DispatchQueue.main.async {
                        completion(phoneDetail)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    private init() {}
    
}

extension URL {
    func setScheme(_ value: String) -> URL? {
        let components = NSURLComponents.init(url: self, resolvingAgainstBaseURL: true)
        components?.scheme = value
        return components?.url
    }
}
