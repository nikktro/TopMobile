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
        var phoneList: [Phone] = []
        
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL)?.setScheme("https") else { return }
        
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                    
                case .success(let value):
                    guard let phoneResponse = value as? [String: Any] else { return }
                    guard let data = phoneResponse["data"] as? [String: Any] else { return }
                    guard let phones = data["phones"] as? [[String: Any]] else { return }
                    
                    for phone in phones {
                        let receivedItem = Phone(
                            phoneName: phone["phone_name"] as? String ?? "",
                            slug: phone["slug"] as? String ?? "",
                            hits: phone["hits"] as? Int ?? 0,
                            detail: phone["detail"] as? String ?? "")
                        phoneList.append(receivedItem)
                    }
                    
                    DispatchQueue.main.async {
                        completion(phoneList)
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
                    guard let detailResponse = value as? [String: Any] else { return }
                    guard let data = detailResponse["data"] as? [String: Any] else { return }
                    
                    let receivedItem = PhoneDetail(
                        brand: data["brand"] as? String ?? "",
                        phoneName: data["phone_name"] as? String ?? "",
                        thumbnail: data["thumbnail"] as? String ?? "",
                        phoneImages: data["phone_images"] as? [String] ?? [""],
                        releaseDate: data["release_date"] as? String ?? "",
                        dimension: data["dimension"] as? String ?? "",
                        os: data["os"] as? String ?? "",
                        storage: data["storage"] as? String ?? "")
                    
                    DispatchQueue.main.async {
                        completion(receivedItem)
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
