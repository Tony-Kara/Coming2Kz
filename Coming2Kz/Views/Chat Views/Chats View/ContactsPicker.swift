//
//  ContactsPicker.swift
//  swiftui-chat
//
//   Created by Tony Eniola on 2023-23-27.
//

import SwiftUI

struct ContactsPicker: View {
  
  @Binding var isContactsPickerShowing: Bool
  @Binding var selectedContacts: [User]
  
  @EnvironmentObject var contactsViewModel: ContactsViewModel
  
  var body: some View {
      
      ZStack {
          
          Color("background")
              .ignoresSafeArea()
          
          VStack (spacing: 0) {
              
              ScrollView {
                  
                  ForEach(contactsViewModel.filteredUsers) { user in
                      let isSelectedContact = selectedContacts.contains { u in
                          u.id == user.id
                      }
                      
                      ZStack {
                          ContactRow(user: user)
                              
                          
                          HStack {
                              Spacer()
                              
                              Button {
                                  
                                  if isSelectedContact {
                                      selectedContacts.removeAll()
                                  }
                                  else {
                                      selectedContacts.removeAll()
                                      selectedContacts.append(user)
                                  }
                                  
                              } label: {
                                  
                                  Image(systemName: isSelectedContact ? "checkmark.circle.fill" :
                                          "checkmark.circle")
                                      .resizable()
                                      .foregroundColor(Color("button-primary"))
                                      .frame(width: 25, height: 25)
                              }

                          }
                      }
                      .padding(.top, 18)
                      .padding(.horizontal)
                  }
              }
              
              Button {
                  isContactsPickerShowing = false
                  
              } label: {
                  
                  ZStack {
                      Color("button-primary")
                      
                      Text("Done")
                          .customFont(.subheadline)
                          .foregroundColor(Color("text-button"))
                  }
              }
              .frame(height: 56)

              
          }
          
      }
      .onAppear {
          contactsViewModel.filterContacts(filterBy: "")
      }
  }
}

