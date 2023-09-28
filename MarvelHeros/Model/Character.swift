//
//  Character.swift
//  MarvelHeros
//
//  Created by iMad on 28/09/2023.
//

import Foundation

struct Character {
    
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: Image?
    let series: SeriesList?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
        case series
    }
}

extension Character: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.thumbnail = try container.decodeIfPresent(Image.self, forKey: .thumbnail)
        self.series = try container.decodeIfPresent(SeriesList.self, forKey: .series)
    }
}

extension Character: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(thumbnail, forKey: .thumbnail)
        try container.encodeIfPresent(series, forKey: .series)
    }
}

