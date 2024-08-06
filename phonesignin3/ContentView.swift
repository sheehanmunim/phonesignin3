//
//  ContentView.swift
//  phonesignin3
//
//  Created by Sheehan Munim on 8/6/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @State private var phoneNumber: String = ""
    @State private var verificationID: String?
    @State private var verificationCode: String = ""
    @State private var isVerificationSent: Bool = false
    @State private var isAuthenticated: Bool = false
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            if isAuthenticated {
                HomeView()
                
            } else {
                if !isVerificationSent {
                    TextField("Phone number", text: $phoneNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .keyboardType(.phonePad)
                    
                    Button(action: sendVerificationCode) {
                        Text("Send Verification Code")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                } else {
                    TextField("Verification code", text: $verificationCode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: verifyCode) {
                        Text("Verify Code")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
        }
        .padding()
    }
    
    private func sendVerificationCode() {
        let phoneNumber = self.phoneNumber
        let phoneNumberWithCountryCode = "+1\(phoneNumber)" // Replace "+1" with the country code if needed
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumberWithCountryCode, uiDelegate: nil) { (verificationID, error) in
                if let error = error {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    return
                }
                self.verificationID = verificationID
                self.isVerificationSent = true
                self.errorMessage = nil
            }
    }
    
    private func verifyCode() {
        guard let verificationID = self.verificationID else {
            self.errorMessage = "Verification ID is missing."
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                self.errorMessage = "Error: \(error.localizedDescription)"
                return
            }
            self.isAuthenticated = true
            self.errorMessage = nil
        }
    }
}

#Preview {
    ContentView()
}
