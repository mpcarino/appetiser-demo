//
//  Requestable.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation
import Moya
import PromiseKit

protocol Requestable {
    @discardableResult func request<T: TargetType, C: Codable> (provider: MoyaProvider<T>, target: T, response: C.Type) -> Promise<C>
    
    @discardableResult func emptyRequest<T: TargetType> (provider: MoyaProvider<T>, target: T) -> Promise<Void>
}
// MARK: - Extensions
extension Requestable {
    var curlPlugin: NetworkLoggerPlugin {
        return NetworkLoggerPlugin(configuration:
            .init(logOptions: .formatRequestAscURL))
    }
    
    @discardableResult func request<T: TargetType, C: Codable> (provider: MoyaProvider<T>, target: T, response: C.Type) -> Promise<C> {
        return Promise<C> { seal in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    let data = response.data
                    
                    print(data)
                    
                    do {
                        let decodedResponse: C = try JSONDecoder().decode(C.self, from: data)
                        seal.fulfill(decodedResponse)
                    } catch(let error) {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    @discardableResult func emptyRequest<T: TargetType> (provider: MoyaProvider<T>, target: T) -> Promise<Void> {
        return Promise<Void> { seal in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    let data = response.data
                    
                    print(data)
                    
                    seal.fulfill(())
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}
