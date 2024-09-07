//
//  EmployeeViewModel.swift
//  Employee Directory
//
//  Created by Tony Buckner on 9/6/24.
//


import Foundation
import SwiftUI

class EmployeeViewModel: ObservableObject {
    
    let networkManager = NetworkManager() // may need to be injected for testing
    
    func getEmployeeList() async throws -> EmployeeModel? {
        return try await networkManager.fetchData(fromEndpoint: .employeesJson, toType: EmployeeModel.self).0
    }
    
    
    
}
