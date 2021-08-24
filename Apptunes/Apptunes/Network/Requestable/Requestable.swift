//
//  Requestable.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

// https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908

import Foundation
import Moya
import PromiseKit

// MARK: - Typealias
typealias EmptyPromise = Promise<Void>

// MARK: - Protocols
protocol Requestable {
    @discardableResult
    func callBasicAPIRequest<T: TargetType> (provider: MoyaProvider<T>, target: T) -> EmptyPromise
    
    @discardableResult
    func callAPIRequest<T: TargetType, C: Codable> (provider: MoyaProvider<T>, target: T, response: C.Type, at keyPath: String?) -> Promise<C>
}

// MARK: - Extensions
extension Requestable {
    var curlPlugin: NetworkLoggerPlugin {
        return NetworkLoggerPlugin(configuration:
            .init(logOptions: .formatRequestAscURL))
    }
    
    /// Perform call to API target then return API response as 'success' or 'failed' an error
    @discardableResult
    func callBasicAPIRequest<T: TargetType> (provider: MoyaProvider<T>, target: T) -> EmptyPromise {
        return EmptyPromise { seal in
            provider.request(target) { result in
                switch result {
                case .success(_):
                    Logger.log(type: .success, title: "API", message: "Successful basic API request: \(target.baseURL)\(target.path)")
                    
                    // Return success
                    seal.fulfill(())
                case .failure(let error):
                    Logger.log(type: .failure, title: "API", message: "Failed basic API request: \(target)")
                
                    // Return failure with error
                    seal.reject(error)
                }
            }
        }
    }
    
    /// Perform call to API target then return API response as 'success' with decoded data or 'failed' with an error
    @discardableResult
    func callAPIRequest<T: TargetType, C: Codable> (provider: MoyaProvider<T>, target: T, response: C.Type, at keyPath: String? = nil) -> Promise<C> {
        return Promise<C> { seal in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    Logger.log(type: .success, title: "API", message: "Successful API request: \(target.baseURL)\(target.path)")
                
                    do {
                        let decodedResponse = try response.map(C.self, atKeyPath: keyPath)
                        
                        // Return success with decoded data
                        seal.fulfill(decodedResponse)
                    } catch(let error) {
                        Logger.log(type: .failure, title: "JSON Mapping", message: "Failed JSON mapping: \(target) - \(type(of: C.self))")
                        
                        // Return failure with error
                        seal.reject(error)
                    }
                case .failure(let error):
                    Logger.log(type: .failure, message: "Failed API request: \(target)")
                    
                    // Return failure with error
                    seal.reject(error)
                }
            }
        }
    }
}
