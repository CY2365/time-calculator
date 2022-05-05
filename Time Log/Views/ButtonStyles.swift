//
//  CopyButton.swift
//  Time Log
//
//  Created by Cenk Yavuz on 05/05/2022.
//

import SwiftUI

struct HightlightWhenPressed: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .aspectRatio(1, contentMode: .fit)
            .foregroundColor(configuration.isPressed ? .white : .blue)
    }
}

//struct CopyButton_Previews: PreviewProvider {
//    static var previews: some View {
//        CopyButton()
//    }
//}
