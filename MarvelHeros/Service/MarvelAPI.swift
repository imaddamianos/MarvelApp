//
//  MarvelAPI.swift
//  MarvelHeros
//
//  Created by iMad on 28/09/2023.
//

import Foundation

class MarvelAPI {
    
    static let shared = MarvelAPI(
        baseURL: URL(string: "https://gateway.marvel.com:443")!,
        privateKey: "c53fecc8e0f9b2ab30de5cfb379b710a849162de",
        apiKey: "79b9d02c524dbc611b62ed9f4a815582"
        
    )

    lazy var characterService: MVLCharacterService = {
        return MVLCharacterService(baseURL: baseURL, privateKey: privateKey, apiKey: apiKey)
    }()
    
    private let baseURL: URL
    private let privateKey: String
    private let apiKey: String
    
    init(baseURL: URL, privateKey: String, apiKey: String) {
        self.baseURL = baseURL
        self.privateKey = privateKey
        self.apiKey = apiKey
    }
    
}
