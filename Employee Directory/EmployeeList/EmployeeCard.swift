//
//  EmployeeCard.swift
//  Employee Directory
//
//  Created by Tony Buckner on 9/6/24.
//

import SwiftUI

struct EmployeeCard: View {
    
    let employee: Employee
    
    var body: some View {
        
        HStack {
            
            // Custom Image Cache View
            AnyView(QuickCache.loadImage(withURL: employee.photo_url_small ?? ""))
                .frame(width: Constants.EmployeeCardSettings.mainImageSize, height: Constants.EmployeeCardSettings.mainImageSize)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: Constants.EmployeeCardSettings.roundRectWidth, height: Constants.EmployeeCardSettings.roundRectHeight)))
            
            Spacer()
            
            VStack(alignment: .leading, spacing: Constants.EmployeeCardSettings.smallSpacing) {
                
                Text(employee.full_name)
                Text(employee.email_address)
                    .font(.system(size: Constants.EmployeeCardSettings.mediumFontSize))
                
                Text(employee.biography ?? "")
                    .font(.system(size: Constants.EmployeeCardSettings.mediumFontSize))
                    .minimumScaleFactor(Constants.EmployeeCardSettings.minimunBioScale)
                
                HStack(spacing: Constants.EmployeeCardSettings.mediumSpacing) {
                    Text(employee.team)
                        .font(.system(size: Constants.EmployeeCardSettings.smallFontSize))
                        .foregroundStyle(.gray)
                }
                
            }
            .frame(minWidth: .zero, maxWidth: .infinity, alignment: .leading)
            .padding()
                
        }
        .padding()
        .background(Color.white)
        
    }
}

#Preview {
    EmployeeCard(employee: Employee(uuid: "8377593387483",
                                    full_name: "Harold Ramis", 
                                    phone_number: nil,
                                    email_address: "harold.ramis@ghostbusters.com",
                                    biography: "I am the start and creator of the Ghostbusters franchise. I am also a mid westerner, born and raised in Illinois",
                                    photo_url_small: "",
                                    photo_url_large: "",
                                    team: "Main app team",
                                    employee_type: .FULL_TIME))
}
