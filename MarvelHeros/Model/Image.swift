//
//  Image.swift
//  MarvelHeros
//
//  Created by iMad on 28/09/2023.
//

import Foundation

struct Image {
    let path: String?
    let ext: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}

extension Image {
    
    var url: URL? {
        if let path = path, let ext = ext {
            return URL(string: "\(path).\(ext)")
        } else {
            return nil
        }
    }
}

extension Image: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decodeIfPresent(String.self, forKey: .path)
        self.ext = try container.decodeIfPresent(String.self, forKey: .ext)
    }
}

extension Image: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(path, forKey: .path)
        try container.encodeIfPresent(ext, forKey: .ext)
    }
}


