//
//  EventsSummary.swift
//  MarvelHeros
//
//  Created by iMad on 29/09/2023.
//

import Foundation

struct EventsSummary {
    
    let resourceURI: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
    }
}

extension EventsSummary: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}

extension EventsSummary: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(resourceURI, forKey: .resourceURI)
        try container.encodeIfPresent(name, forKey: .name)
        
    }
}
