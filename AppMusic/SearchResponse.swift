//
//  SearchResponse.swift
//  AppMusic
//
//  Created by Алексей Черанёв on 05.10.2021.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String?
    var collectionName: String?
    var artistName: String
    var artworkUrl100: String?
}
