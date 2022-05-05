//
//  Information.swift
//  Time Log
//
//  Created by Cenk Yavuz on 04/05/2022.
//

import SwiftUI

struct Settings: View {
    
    @EnvironmentObject var calculator: Calculator
    @Binding var showInfo: Bool
    @State var copyButtonSelection = "Result Only"
    
    private let copyButtonOptions = ["Result Only", "Full Calculation"]
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    private var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: Date())
    }
    
    init(_ bool: Binding<Bool>){
        self._showInfo = bool
        UITableView.appearance().separatorColor = .black
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    
    var body: some View {
        
            ZStack {
                Color.calculatorBackground
                    .ignoresSafeArea()
                VStack {
                    topButtons
                    Form {
                        pickerButton
                        SettingRow(key: "Version", value: appVersion ?? "")
                        reviewButton
                    }
                    Spacer()
                    footer
                }
            }
        
    }
    
    private var topButtons: some View {
        HStack {
            Spacer()
            Button {
                showInfo = false
            } label: {
                Image(systemName: "x.square.fill")
            }
            .font(.system(size: 24))
        }.padding()
    }
    
    private var pickerButton: some View {
        Picker("Copy Button", selection: $copyButtonSelection) {
            ForEach(copyButtonOptions, id: \.self) { button in
                Text(button)
            }
        }
        .pickerStyle(.inline)
        .listRowBackground(Color.buttonBackground)
        .foregroundColor(.white)
        .onChange(of: copyButtonSelection) { newValue in
            if newValue == "Result Only" {
                calculator.copyResultOnly = true
            } else {
                calculator.copyResultOnly = false
            }
        }
    }
    
    private var reviewButton: some View {
        Button {
            requestReviewManually()
        } label: {
            Text("Review in the App Store")
        }.listRowBackground(Color.buttonBackground)
    }
    
    private var footer: some View {
        VStack {
            Text("For support, suggestions or questions please contact support@cenkyavuz.io")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 250)
                .padding()
                .font(.system(size: 12, weight: .light, design: .rounded))
            Text("\(year), CY")
                .foregroundColor(.white)
                .font(.system(size: 10, weight: .light, design: .rounded))
        }
    }
    
    private func requestReviewManually() {
        guard let writeReviewURL = URL(string: "https://apps.apple.com/us/app/id1622087939?action=write-review")
        else { fatalError("Expected a valid URL") }
        DispatchQueue.main.async {
            UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
        }
    }
    
}


struct Information_Previews: PreviewProvider {
    static var previews: some View {
        Settings(.constant(true))
    }
}
