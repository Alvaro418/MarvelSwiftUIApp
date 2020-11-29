//
//  CharacterDetailModel.swift
//  marvelapp
//
//  Created by Alvaro Exposito on 25/11/2020.
//

import Foundation

// MARK: - CharacterDetailModel
struct CharacterDetailModel: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataClass?
}

