//
//  ItunesService.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation
import Moya
import PromiseKit
import SwiftyJSON

struct ItunesService: Requestable {
    /// Get data from search API, received as JSON data
    func getTracks() -> Promise<[ItunesTrack]> {
        let provider = MoyaProvider<MoyaItunesService>(plugins: [curlPlugin])
        let target = MoyaItunesService.search
        
        return callAPIRequest(provider: provider, target: target, response: [ItunesTrack].self, at: "results")
    }

    /// Get data from search API, received as .txt file then convert contents into JSON data
    func downloadTracks(completion: @escaping ([ItunesTrack]) -> Void) {
        if let url = URL(string: L10n.APIs.Url.root + L10n.APIs.Path.search) {
            DispatchQueue.global().async {
                
                // Convert data content of .txt file to JSON data
                if let string = try? String(contentsOf: url) {
                    let json = JSON(parseJSON: string)
                    let results = json["results"]
                    
                    // Map JSON data to an array of 'ItunesTrack' then update shared data
                    if let decodedResponse = try? JSONDecoder().decode([ItunesTrack].self, from: results.rawData()) {
                        UserDataManager.shared.itunesTracks = decodedResponse
                    }
                }
                
                completion(UserDataManager.shared.itunesTracks)
            }
        }
    }
}

