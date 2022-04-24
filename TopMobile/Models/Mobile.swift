//
//  Mobile.swift
//  TopMobile
//
//  Created by Nikolay Trofimov on 20.04.2022.
//

import Foundation

struct PhoneResponse: Decodable {
    let status: Bool
    let data: PhoneSpec
}

struct PhoneSpec: Decodable {
    let title: String
    let phones: [Phone]
}

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
}

struct DetailResponse: Decodable {
    let status: Bool
    let data: PhoneDetail
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
    
}
