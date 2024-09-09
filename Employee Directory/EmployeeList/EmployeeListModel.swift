//
//  EmployeeModel.swift
//  Employee Directory
//
//  Created by Tony Buckner on 9/6/24.
//

import Foundation

struct EmployeeListModel: Codable, Hashable {
    let employees: [Employee]
}

struct Employee: Codable, Hashable {
    let uuid: String
    let full_name: String
    let phone_number: String?
    let email_address: String
    let biography: String?
    let photo_url_small: String?
    let photo_url_large: String?
    let team: String
    let employee_type: Employee_Type
}

enum Employee_Type: String, Codable, Hashable {
    case FULL_TIME
    case PART_TIME
    case CONTRACTOR
}
