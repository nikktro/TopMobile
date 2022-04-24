//
//  NetworkManager.swift
//  TopMobile
//
//  Created by Nikolay Trofimov on 23.04.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData<T:Decodable>(url: String, type: T.Type, completion: @escaping(T?, Error?) -> Void) {
        
        guard let url = URL(string: url)?.setScheme("https") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let dataReceived = try JSONDecoder().decode(type, from: data)
                completion(dataReceived, nil)
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }.resume()
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
