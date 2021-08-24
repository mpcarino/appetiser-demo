//
//  ItunesTrack.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation

struct ItunesTrack: Codable {
    let id: Int
    let type: String
    let kind: String
    let artistName: String
    let collectionName: String
    let trackName: String
    let trackViewUrl: String
    let previewUrl: String
    let trackPrice: Double
    let currency: String
    let country: String
    let artworkSmallUrl: String
    let artworkMediumUrl: String
    let artworkLargeUrl: String
    let primaryGenreName: String
    let longDescription: String
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case type = "wrapperType"
        case kind
        case artistName
        case collectionName
        case trackName
        case trackViewUrl
        case previewUrl
        case trackPrice
        case currency
        case country
        case artworkSmallUrl = "artworkUrl30"
        case artworkMediumUrl = "artworkUrl60"
        case artworkLargeUrl = "artworkUrl100"
        case primaryGenreName
        case longDescription = "description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? .zero
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        kind = try container.decodeIfPresent(String.self, forKey: .kind) ?? ""
        artistName = try container.decodeIfPresent(String.self, forKey: .artistName) ?? "-"
        collectionName = try container.decodeIfPresent(String.self, forKey: .collectionName) ?? "-"
        trackName = try container.decodeIfPresent(String.self, forKey: .trackName) ?? "-"
        trackViewUrl = try container.decodeIfPresent(String.self, forKey: .trackViewUrl) ?? ""
        previewUrl = try container.decodeIfPresent(String.self, forKey: .previewUrl) ?? ""
        trackPrice = try container.decodeIfPresent(Double.self, forKey: .trackPrice) ?? .zero
        currency = try container.decodeIfPresent(String.self, forKey: .currency) ?? "-"
        country = try container.decodeIfPresent(String.self, forKey: .country) ?? "-"
        artworkSmallUrl = try container.decodeIfPresent(String.self, forKey: .artworkSmallUrl) ?? ""
        artworkMediumUrl = try container.decodeIfPresent(String.self, forKey: .artworkMediumUrl) ?? ""
        artworkLargeUrl = try container.decodeIfPresent(String.self, forKey: .artworkLargeUrl) ?? ""
        primaryGenreName = try container.decodeIfPresent(String.self, forKey: .primaryGenreName) ?? "-"
        longDescription = try container.decodeIfPresent(String.self, forKey: .longDescription) ?? ""
    }
}

extension ItunesTrack {
    var officialKind: ItunesTrackKind? {
        return ItunesTrackKind(rawValue: kind)
    }
}
