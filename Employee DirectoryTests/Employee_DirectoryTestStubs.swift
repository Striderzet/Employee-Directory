//
//  Employee_DirectoryTestStubs.swift
//  Employee DirectoryTests
//
//  Created by Tony Buckner on 9/9/24.
//

import Foundation
@testable import Employee_Directory

// MARK: - Network Manager Stub

struct StubNetworkManager: NetworkManagerProtocol {
    
    var response: HTTPURLResponse
    var employeeListModel: EmployeeListModel?
    
    /// This will test all network errors at the moment, as doing data conversions will take more project time
    func fetchData<T>(fromEndpoint urlString: Employee_Directory.Constants.URL, toType type: T.Type) async throws -> T where T : Decodable {
        if employeeListModel == nil {
            let data = Data()
            let fetchedData = try JSONDecoder().decode(T.self, from: try NetworkManagerMethods.mapResponse(response: (data, response)))
            return fetchedData
        } else {
            return employeeListModel as! T
        }
    }
    
}
