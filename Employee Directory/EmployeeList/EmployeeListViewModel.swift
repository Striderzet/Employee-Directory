//
//  EmployeeViewModel.swift
//  Employee Directory
//
//  Created by Tony Buckner on 9/6/24.
//


import Foundation
import SwiftUI

class EmployeeListViewModel: ObservableObject {
    
    private let networkManager = NetworkManager() // may need to be injected for testing
    
    private func fetchEmployeeList() async throws -> EmployeeListModel? {
        return try await networkManager.fetchData(fromEndpoint: .employeesJson, toType: EmployeeListModel.self)
    }
    
    @MainActor
    func setEmployeeList(employeeList: Binding<EmployeeListModel?>) async {
        employeeList.wrappedValue = nil
        do {
            employeeList.wrappedValue = try await fetchEmployeeList()
        } catch {
            print("There was an error with the request: \(error)")
        }
    }
    
}
