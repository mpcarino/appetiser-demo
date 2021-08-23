//
//  ItunesService.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation
import Moya
import PromiseKit

typealias EmptyPromise = Promise<Void>

struct ItunesService: Requestable {
    func search() -> EmptyPromise {
        let provider = MoyaProvider<MoyaItunesService>(plugins: [curlPlugin])
        let target = MoyaItunesService.search
        
        return emptyRequest(provider: provider, target: target)
    }
}
