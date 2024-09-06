//
//  NetworkManager.swift
//  Employee Directory
//
//  Created by Tony Buckner on 9/6/24.
//

import Combine
import Foundation
import SwiftUI

class NetworkManager {
    
    /// Note: Will incorporate tests here, and also will possibly user future promise to handle response
    func fetchData<T: Decodable>(fromEndpoint urlString: Constants.URL,
                                 toType type: T.Type) async throws -> (T, URLResponse) {
        
        let url = URL(string: urlString.rawValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        let request = URLRequest(url: url!)
        let (data, response) = try await URLSession.shared.data(for: request)
        let fetchedData = try JSONDecoder().decode(T.self, from: data)
        return (fetchedData, response)
        
    }
    
}
