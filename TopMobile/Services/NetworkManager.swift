//
//  NetworkManager.swift
//  TopMobile
//
//  Created by Nikolay Trofimov on 23.04.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData<T:Decodable>(from url: String?, forType type: T.Type, with completion: @escaping(T) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL)?.setScheme("https") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let dataReceived = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(dataReceived)
                }
            } catch let error {
                print(error.localizedDescription)
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
