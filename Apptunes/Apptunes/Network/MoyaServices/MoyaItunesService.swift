//
//  MoyaItunesService.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation
import Moya

enum MoyaItunesService {
    case search
}

extension MoyaItunesService: TargetType {
    var baseURL: URL {
        return URL(string: L10n.APIs.Url.root)!
    }
    
    var path: String {
        switch self {
        case .search:
            return L10n.APIs.Path.search
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .search:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}


