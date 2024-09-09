//
//  EmployeeList.swift
//  Employee Directory
//
//  Created by Tony Buckner on 9/9/24.
//

import SwiftUI

struct EmployeeListView: View {
    
    @StateObject var employeeViewModel = EmployeeListViewModel(networkManger: NetworkManager())
    @State var employeeList: EmployeeListModel? // Kept local for UI updates on correct thread
    
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
                await employeeViewModel.setEmployeeList(employeeList: $employeeList)
            }
            
        }
        .refreshable {
            await employeeViewModel.setEmployeeList(employeeList: $employeeList)
        }
        
    }
        
}

#Preview {
    EmployeeListView()
}
