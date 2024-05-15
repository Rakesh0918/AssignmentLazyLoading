//
//  Model.swift
//  LazyDemo
//
//  Created by Rakesh Sharma on 16/05/24.
//

import Foundation

struct ImageModel: Codable {
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    let domain: String?
    let basePath: String?
    let key: String?
}
