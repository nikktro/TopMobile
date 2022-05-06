//
//  Mobile.swift
//  TopMobile
//
//  Created by Nikolay Trofimov on 20.04.2022.
//

import Foundation

struct Phone: Decodable {
    let phoneName: String
    let slug: String
    let hits: Int
    let detail: String
    var thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case phoneName = "phone_name"
        case slug, hits, detail, thumbnail
    }
    
    static func getPhones(from value: Any) -> [Phone]? {
        var phoneList: [Phone] = []
        
        guard let phoneResponse = value as? [String: Any] else { return nil }
        guard let data = phoneResponse["data"] as? [String: Any] else { return nil }
        guard let phones = data["phones"] as? [[String: Any]] else { return nil }
        
        for phone in phones {
            let receivedItem = Phone(
                phoneName: phone["phone_name"] as? String ?? "",
                slug: phone["slug"] as? String ?? "",
                hits: phone["hits"] as? Int ?? 0,
                detail: phone["detail"] as? String ?? "")
            phoneList.append(receivedItem)
        }
        
        return phoneList
    }
}

struct PhoneDetail: Decodable {
    let brand: String
    let phoneName: String
    let thumbnail: String
    let phoneImages: [String]
    let releaseDate: String
    let dimension: String
    let os: String
    let storage: String
    
    var fullName: String {
        "\(brand) \(phoneName)"
    }
    
    enum CodingKeys: String, CodingKey {
        case phoneName = "phone_name"
        case phoneImages = "phone_images"
        case releaseDate = "release_date"
        case brand, thumbnail, dimension, os, storage
    }
    
    static func getPhoneDetail(from value: Any) -> PhoneDetail? {
        guard let detailResponse = value as? [String: Any] else { return nil }
        guard let data = detailResponse["data"] as? [String: Any] else { return nil }
        
        let phoneDetail = PhoneDetail(
            brand: data["brand"] as? String ?? "",
            phoneName: data["phone_name"] as? String ?? "",
            thumbnail: data["thumbnail"] as? String ?? "",
            phoneImages: data["phone_images"] as? [String] ?? [""],
            releaseDate: data["release_date"] as? String ?? "",
            dimension: data["dimension"] as? String ?? "",
            os: data["os"] as? String ?? "",
            storage: data["storage"] as? String ?? "")
        
        return phoneDetail
    }
    
}

enum Link: String {
    case mobilespecs = "https://api-mobilespecs.azharimm.site/v2/top-by-interest"
}
