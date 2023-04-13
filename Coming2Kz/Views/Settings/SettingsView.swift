//
//  SettingsView.swift
//  Coming2Kz
//
//  Created by Tony-eniola on 4/13/23.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isSettingsShowing: Bool
    @Binding var isOnboarding: Bool
    
   @State var isDarkMode = false
    
    var body: some View {
        
        
        
        ZStack {
            
            // Background
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                // Heading
                HStack {
                    Text("Settings")
                        .customFont(.largeTitle)
                    
                    Spacer()
                    
                    Button {
                        // Close settings view
                        isSettingsShowing = false
                        
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .tint(Color("icons-secondary"))
                    }
                    
                    
                }
                .padding(.top, 20)
                .padding(.horizontal)
                
                // The Form
                Form {

                    Toggle("Dark Mode", isOn: $isDarkMode)

                    Button {
                        // Log out
                        AuthViewModel.logout()

                        // Show login screen again
                        isOnboarding = true

                    } label: {
                        Text("Log Out")
                    }

                    Button {
                        // TODO: Delete Account
                    } label: {
                        Text("Delete Account")
                    }


                }
            }
            
        }
        
        
    }
}

