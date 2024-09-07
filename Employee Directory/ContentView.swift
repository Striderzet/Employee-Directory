//
//  ContentView.swift
//  Employee Directory
//
//  Created by Tony Buckner on 9/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var employeeViewModel = EmployeeViewModel()
    @State var employeeList: EmployeeModel? // Kept local for UI updates on correct thread
    
    private let employeeListContainer = ContainerService.resolver.resolveEmployeeList()
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                if let employees = employeeList?.employees,
                   !employees.isEmpty {
                    ForEach(employees, id:\.self) { employee in
                        EmployeeCard(employee: employee)
                    }
                } else {
                    Text("There are no employees available. Pull list down to refresh.")
                        .padding()
                }
            }
            .padding()
            .task {
                if employeeListContainer.employeeList.value == nil {
                    await getEmployeeList()
                } else {
                   employeeList = employeeListContainer.employeeList.value
                }
            }
            
        }
        .refreshable {
            await getEmployeeList()
        }
    }
    
    private func getEmployeeList() async {
        do {
            employeeList = try await employeeViewModel.getEmployeeList()
            employeeListContainer.employeeList.send(employeeList)
        } catch {
            print(error)
        }
    }
}

#Preview {
    ContentView()
}
