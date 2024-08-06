//
//  InitialView.swift
//  phonesignin3
//
//  Created by Sheehan Munim on 8/6/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct InitialView: View {
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)
    
    
    var body: some View {
        VStack{
            if userLoggedIn{
                HomeView()
            } else {
                ContentView()
            }
            
            
        }.onAppear{
            
            Auth.auth().addStateDidChangeListener{auth, user in
            
                if (user != nil) {
                    
                    userLoggedIn = true
                } else{
                    userLoggedIn = false
                }
            }
        }
    }
}
