//
//  Employee_DirectoryTests.swift
//  Employee DirectoryTests
//
//  Created by Tony Buckner on 9/6/24.
//

import SwiftUI
import XCTest
@testable import Employee_Directory

final class Employee_DirectoryTests: XCTestCase {

    // MARK: - Employee List View Model Tests
    
    func testEmployeeListViewModelFetchPopulation() async throws {
        
        var bindingValue: EmployeeListModel?
        var employeeList = Binding(get: { bindingValue }, set: { bindingValue = $0 })
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 200, httpVersion: "", headerFields: [:]) else { return  }
        let networkManager = makeNetworkManagerSUT(response: requestResponse, employeeListModel: EmployeeListModel(employees: [employee1, employee2]))
        let viewModel = EmployeeListViewModel(networkManger: networkManager)
        await viewModel.setEmployeeList(employeeList: employeeList)
        XCTAssertTrue(!(employeeList.wrappedValue?.employees.isEmpty ?? true))
        
    }
    
    func testEmployeeListViewModelFetchEmpty() async throws {
        
        var bindingValue: EmployeeListModel?
        let employeeList = Binding(get: { bindingValue }, set: { bindingValue = $0 })
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 200, httpVersion: "", headerFields: [:]) else { return  }
        let networkManager = makeNetworkManagerSUT(response: requestResponse, employeeListModel: employeeList.wrappedValue)
        let viewModel = EmployeeListViewModel(networkManger: networkManager)
        await viewModel.setEmployeeList(employeeList: employeeList)
        XCTAssertTrue(employeeList.wrappedValue == nil)
        
    }
    
    func testtestEmployeeListViewModelFetchErrors() async throws {
        
        var bindingValue: EmployeeListModel?
        let employeeList = Binding(get: { bindingValue }, set: { bindingValue = $0 })
        
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 400, httpVersion: "", headerFields: [:]) else { return  }
        var networkManager = makeNetworkManagerSUT(response: requestResponse, employeeListModel: employeeList.wrappedValue)
        var viewModel = EmployeeListViewModel(networkManger: networkManager)
        await viewModel.setEmployeeList(employeeList: employeeList)
        XCTAssertTrue(viewModel.networkError == NetworkError.badRequest.localizedDescription)
        
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 401, httpVersion: "", headerFields: [:]) else { return  }
        networkManager = makeNetworkManagerSUT(response: requestResponse, employeeListModel: employeeList.wrappedValue)
        viewModel = EmployeeListViewModel(networkManger: networkManager)
        await viewModel.setEmployeeList(employeeList: employeeList)
        XCTAssertTrue(viewModel.networkError == NetworkError.unauthorized.localizedDescription)
        
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 402, httpVersion: "", headerFields: [:]) else { return  }
        networkManager = makeNetworkManagerSUT(response: requestResponse, employeeListModel: employeeList.wrappedValue)
        viewModel = EmployeeListViewModel(networkManger: networkManager)
        await viewModel.setEmployeeList(employeeList: employeeList)
        XCTAssertTrue(viewModel.networkError == NetworkError.paymentRequired.localizedDescription)
        
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 403, httpVersion: "", headerFields: [:]) else { return  }
        networkManager = makeNetworkManagerSUT(response: requestResponse, employeeListModel: employeeList.wrappedValue)
        viewModel = EmployeeListViewModel(networkManger: networkManager)
        await viewModel.setEmployeeList(employeeList: employeeList)
        XCTAssertTrue(viewModel.networkError == NetworkError.forbidden.localizedDescription)
        
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 404, httpVersion: "", headerFields: [:]) else { return  }
        networkManager = makeNetworkManagerSUT(response: requestResponse, employeeListModel: employeeList.wrappedValue)
        viewModel = EmployeeListViewModel(networkManger: networkManager)
        await viewModel.setEmployeeList(employeeList: employeeList)
        XCTAssertTrue(viewModel.networkError == NetworkError.notFound.localizedDescription)
        
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 413, httpVersion: "", headerFields: [:]) else { return  }
        networkManager = makeNetworkManagerSUT(response: requestResponse, employeeListModel: employeeList.wrappedValue)
        viewModel = EmployeeListViewModel(networkManger: networkManager)
        await viewModel.setEmployeeList(employeeList: employeeList)
        XCTAssertTrue(viewModel.networkError == NetworkError.requestEntityTooLarge.localizedDescription)
        
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 422, httpVersion: "", headerFields: [:]) else { return  }
        networkManager = makeNetworkManagerSUT(response: requestResponse, employeeListModel: employeeList.wrappedValue)
        viewModel = EmployeeListViewModel(networkManger: networkManager)
        await viewModel.setEmployeeList(employeeList: employeeList)
        XCTAssertTrue(viewModel.networkError == NetworkError.unprocessableEntity.localizedDescription)
        
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 500, httpVersion: "", headerFields: [:]) else { return  }
        networkManager = makeNetworkManagerSUT(response: requestResponse, employeeListModel: employeeList.wrappedValue)
        viewModel = EmployeeListViewModel(networkManger: networkManager)
        await viewModel.setEmployeeList(employeeList: employeeList)
        XCTAssertTrue(!viewModel.networkError.isEmpty)
        
    }
    
    // Employee Mock Data
    let employee1 = Employee(uuid: "8377593387483",
                             full_name: "Harold Ramis",
                             phone_number: nil,
                             email_address: "harold.ramis@ghostbusters.com",
                             biography: "I am the start and creator of the Ghostbusters franchise. I am also a mid westerner, born and raised in Illinois",
                             photo_url_small: "",
                             photo_url_large: "",
                             team: "Main app team",
                             employee_type: .FULL_TIME)
    
    let employee2 = Employee(uuid: "8377593389743",
                             full_name: "Steve Martin",
                             phone_number: "3215556792",
                             email_address: "steve.martin@thejerk.com",
                             biography: "I do absurd standup comedy",
                             photo_url_small: "",
                             photo_url_large: "",
                             team: "Main app team",
                             employee_type: .CONTRACTOR)
    
    // Subject Under Test
    func makeNetworkManagerSUT(response: HTTPURLResponse, 
                               employeeListModel: EmployeeListModel? = nil) -> NetworkManagerProtocol {
        
        return StubNetworkManager(response: response,
                                  employeeListModel: employeeListModel)
        
    }

}
