//
//  NetworkManager.swift
//  Employee Directory
//
//  Created by Tony Buckner on 9/6/24.
//

import Combine
import Foundation
import SwiftUI

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(fromEndpoint urlString: Constants.URL,
                                 toType type: T.Type) async throws -> T
}

class NetworkManager: NetworkManagerProtocol {
    
    /// With fetch data according to the API call selected (URL string here) and the data type selected
    /// - Parameters:
    ///   - urlString: "API call"
    ///   - type: Data model type
    /// - Returns: The requested data model parsed from the returned data if successful
    func fetchData<T: Decodable>(fromEndpoint urlString: Constants.URL,
                                 toType type: T.Type) async throws -> T {
        
        let url = URL(string: urlString.rawValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        let request = URLRequest(url: url!)
        let (data, response) = try await URLSession.shared.data(for: request)
        let fetchedData = try JSONDecoder().decode(T.self, from: try NetworkManagerMethods.mapResponse(response: (data, response)))
        return fetchedData
        
    }
    
}

struct NetworkManagerMethods {
    
    /// This method will parse and handle possible network errors from our async await network calls
    /// - Parameter response: The response that will need to be parsed to determine what error was sent back from the request
    /// - Returns: The requested data
    static func mapResponse(response: (data: Data, response: URLResponse)) throws -> Data {
        
        guard let httpResponse = response.response as? HTTPURLResponse else {
            return response.data
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return response.data
        case 400:
            throw NetworkError.badRequest
        case 401:
            throw NetworkError.unauthorized
        case 402:
            throw NetworkError.paymentRequired
        case 403:
            throw NetworkError.forbidden
        case 404:
            throw NetworkError.notFound
        case 413:
            throw NetworkError.requestEntityTooLarge
        case 422:
            throw NetworkError.unprocessableEntity
        default:
            throw NetworkError.http(httpResponse: httpResponse, data: response.data)
        }
        
    }
    
}

public enum NetworkError: Error, LocalizedError {
    case missingRequiredFields(String)
    case invalidParameters(operation: String, parameters: [Any])
    case badRequest
    case unauthorized
    case paymentRequired
    case forbidden
    case notFound
    case requestEntityTooLarge
    case unprocessableEntity
    case http(httpResponse: HTTPURLResponse, data: Data)
    case invalidResponse(Data)
    case deleteOperationFailed(String)
    case network(URLError)
    case unknown(Error?)
}
