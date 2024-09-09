//
//  Constants.swift
//  Employee Directory
//
//  Created by Tony Buckner on 9/6/24.
//

import Foundation

struct Constants {
    
    /// For this application, since we have complete URL"s with access to S3 buckets, we will keep it simple here
    enum URL: String {
        case employeesJson = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
        case employeesMalformedJson = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
        case employeesEmptyJson = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
    }
    
    struct EmployeeCardSettings {
        static let mainImageSize: CGFloat = 100
        static let smallFontSize: CGFloat = 10
        static let mediumFontSize: CGFloat = 12
        static let smallSpacing: CGFloat = 2
        static let mediumSpacing: CGFloat = 8
        static let minimunBioScale: CGFloat = 0.3
        static let roundRectWidth: CGFloat = 20
        static let roundRectHeight: CGFloat = 10
    }
    
}
