//
//  ContentView.swift
//  Employee Directory
//
//  Created by Tony Buckner on 9/6/24.
//

import SwiftUI

struct ContentView: View {
    
    let networkManager = NetworkManager()
    @State var employeeList: EmployeeModel?
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                if let employees = employeeList?.employees {
                    ForEach(employees, id:\.self) { employee in
                        EmployeeCard(employee: employee)
                    }
                } else {
                    Text("Empty State Here....")
                }
            }
            .padding()
            .task {
                do {
                    employeeList = try await networkManager.fetchData(fromEndpoint: .employeesJson, toType: EmployeeModel.self).0
                    print("Fetched list: \(String(describing: employeeList))")
                } catch {
                    print("There was an error: \(error)")
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
