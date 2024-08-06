//
//  HomeView.swift
//  phonesignin3
//
//  Created by Sheehan Munim on 8/6/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct HomeView: View {
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            Button{
                Task{
                    do{
                        try await logout()
                    }
                }
                } label: {
                    Text("Log Out").padding(8)
                }.buttonStyle(.borderedProminent)

                
        
            }
            .padding()
        }
    
    func logout() async throws{
        try Auth.auth().signOut()
    }
}

#Preview {
    HomeView()
}
