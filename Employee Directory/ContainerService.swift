//
//  ContainerService.swift
//  Employee Directory
//
//  Created by Tony Buckner on 9/7/24.
//

import Combine
import Foundation

/// - Note: This will be kepi in on file for this project

// MARK: - Employee List Object

protocol EmployeeListProtocol {
    var employeeList: CurrentValueSubject<EmployeeModel?, Never> { get set }
}

final class EmployeeList: EmployeeListProtocol {
    var employeeList = CurrentValueSubject<EmployeeModel?, Never>(nil)
}

// MARK: - Container Service

class ContainerService {
    
    static let resolver = ContainerService()
    
    // Employee List Container
    
    private let employeeList = EmployeeList()
    
    func resolveEmployeeList() -> EmployeeListProtocol {
        return employeeList
    }
}
