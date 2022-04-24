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
    
    enum CodingKeys: String, CodingKey {
        case phoneName = "phone_name"
        case slug, hits, detail
    }
}

struct DetailResponse: Decodable {
    let status: Bool
    let data: PhoneDetail
}

struct PhoneDetail: Decodable {
    let brand: String
    let phone_name: String
    let thumbnail: String
    let phone_images: [String]
    let release_date: String
    let dimension: String
    let os: String
    let storage: String
}
