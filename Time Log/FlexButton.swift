//
//  FlexButton.swift
//  Time Log
//
//  Created by Cenk Yavuz on 26/04/2022.
//

import SwiftUI

struct FlexButton: View {
    
    let text: String
    let action: () -> Void
    
    init(_ text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button(text, action: action).frame(maxWidth: .infinity, maxHeight: 50)
    }
}

//struct FlexButton_Previews: PreviewProvider {
//    static var previews: some View {
//        FlexButton()
//    }
//}
