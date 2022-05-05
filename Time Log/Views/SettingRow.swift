//
//  SettingRow.swift
//  Time Log
//
//  Created by Cenk Yavuz on 05/05/2022.
//

import SwiftUI

struct SettingRow: View {
    let key: String
    let value: String
    
    var body: some View {
        HStack {
            Text(key + ":")
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .foregroundColor(.white)
        }
        .listRowBackground(Color.buttonBackground)
    }
}

struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingRow(key: "Test", value: "123")
    }
}
