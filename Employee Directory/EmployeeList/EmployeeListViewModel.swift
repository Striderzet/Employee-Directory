//
//  EmployeeViewModel.swift
//  Employee Directory
//
//  Created by Tony Buckner on 9/6/24.
//


import Foundation
import SwiftUI

protocol EmployeeListViewModelProtocol {
    func fetchEmployeeList() async throws -> EmployeeListModel?
    @MainActor
    func setEmployeeList(employeeList: Binding<EmployeeListModel?>) async
}

class EmployeeListViewModel: EmployeeListViewModelProtocol, ObservableObject {
    
    @Published var networkError = ""
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManger: NetworkManagerProtocol) {
        self.networkManager = networkManger
    }
    
    internal func fetchEmployeeList() async throws -> EmployeeListModel? {
        return try await networkManager.fetchData(fromEndpoint: .employeesJson, toType: EmployeeListModel.self)
    }
    
    @MainActor
    func setEmployeeList(employeeList: Binding<EmployeeListModel?>) async {
        
        /// - Note: if this is not done, the list will not reload and the cached images will not populate. It could be looked into
        ///     - Also, this has much better UX if i use an escaping closure to update the value in the view, but i would have to change too much code here and add time.
        ///     - This can be done later.
        employeeList.wrappedValue = nil
        
        do {
            employeeList.wrappedValue = try await fetchEmployeeList()
        } catch {
            print("There was an error with the request: \(error)")
            networkError = error.localizedDescription
        }
    }
    
}
