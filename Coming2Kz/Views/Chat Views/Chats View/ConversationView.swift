import SwiftUI

struct ConversationView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @Binding var isChatShowing: Bool
  
  @State var selectedImage: UIImage?
  @State var isPickerShowing = false
  @State var isSourceDialogShowing = false
  @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    @State var chatMessage = ""
    @State var participants = [User]()
    
    var body: some View {
        
      VStack (spacing: 0) {
            
            // Chat header
            HStack {
                VStack (alignment: .leading) {
                    
                    // Back arrow
                    Button {
                        // Dismiss chat window
                        isChatShowing = false
                        
                    } label: {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color("text-header"))
                    }
                    .padding(.bottom, 16)
                    
                    // Name
                  if participants.count > 0 {
                    let participant = participants.first
                    Text("\(participant?.firstname ?? "") \(participant?.lastname ?? "")")
                    .customFont(.headline)
                        .foregroundColor(Color("text-header"))
                  }
                    
                }
                
                Spacer()
                
                // Profile image
              if participants.count > 0 {
                let participant = participants.first
                ProfilePicView(user: participant!)
              }
                
            }
            .padding(.horizontal)
            .frame(height: 104)
            
            // Chat log
        ScrollViewReader { proxy in
          ScrollView {
            
            VStack (spacing: 24) {
              
              ForEach (Array(chatViewModel.messages.enumerated()), id: \.element) { index, msg in
                
                let isFromUser = msg.senderid == AuthViewModel.getLoggedInUserId()
                
                HStack {
                  
                  if isFromUser {
                    // Timestamp
                    Text(DateHelper.chatTimestampFrom(date: msg.timestamp))
                      .customFont(.caption)
                      .foregroundColor(Color("text-timestamp"))
                      .padding(.trailing)
                    
                    Spacer()
                  }
                  
                  if msg.imageurl != "" {
                    let photoUrl = URL(string: msg.imageurl!)
                      AsyncImage(url: photoUrl) { phase in
                          
                          switch phase {
                              
                          case .empty:
                              ProgressView()
                              
                          case .success(let image):
                            image
                              .resizable()
                              .scaledToFill()
                              .padding(.vertical, 16)
                              .padding(.horizontal, 24)
                              .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
                              .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                          case .failure:
                            Text("Couldn't load image")
                              .customFont(.subheadline)
                              .foregroundColor(isFromUser ? Color("text-button") : Color("text-primary"))
                              .padding(.vertical, 16)
                              .padding(.horizontal, 24)
                              .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
                              .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                          }
                          
                      }
                  }
                  else {
                    Text(msg.msg)
                      .customFont(.subheadline)
                      .foregroundColor(isFromUser ? Color("text-button") : Color("text-primary"))
                      .padding(.vertical, 16)
                      .padding(.horizontal, 24)
                      .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
                      .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                  }
                  
                  if !isFromUser {
                    Spacer()
                    
                    // Timestamp
                    Text(DateHelper.chatTimestampFrom(date: msg.timestamp))
                      .customFont(.caption)
                      .foregroundColor(Color("text-timestamp"))
                      .padding(.leading)
                  }
                }
                .id(index)
              }
              
              
              
            }
            .padding(.horizontal)
            .padding(.top, 24)
            
          }
          .background(Color("backgroundc"))
          .onChange(of: chatViewModel.messages.count) { newCount in
            withAnimation {
              proxy.scrollTo(newCount - 1)
            }
            
          }
          
        }
            // Chat message bar
            ZStack {
                Color("backgroundc")
                    .ignoresSafeArea()
                
              HStack (spacing: 15) {
                    // Camera button
                    Button {
                      isSourceDialogShowing = true
                    } label: {
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-secondary"))
                    }

                    // Textfield
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(Color("date-pill"))
                            .cornerRadius(50)
                      
                      if selectedImage != nil {
                        Text("Image")
                          .foregroundColor(Color("text-input"))
                          .customFont(.subheadline)
                          .padding(10)
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                selectedImage = nil
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Color("text-input"))
                            }
                        }
                        .padding(.trailing, 12)
                      }
                      else {
                        
                        TextField("Type your message", text: $chatMessage)
                            .foregroundColor(Color("text-input"))
                            .customFont(.subheadline)
                            .padding(10)
                        
                        // Emoji button
                        HStack {
                            Spacer()
                            
                            Button {
                                // Emojis
                            } label: {
                                Image(systemName: "face.smiling")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Color("text-input"))
                            }
                        }
                        .padding(.trailing, 12)
                      }
                    }
                    .frame(height: 44)
                    
                    
                    // Send button
                    Button {
                      
                      if selectedImage != nil {
                        chatViewModel.sendPhotoMessage(image: selectedImage!)
                        selectedImage = nil
                      }
                      else {
                        chatMessage = chatMessage.trimmingCharacters(in: .whitespacesAndNewlines)
                        chatViewModel.sendMessage(msg: chatMessage)
                        chatMessage = ""
                      }
                      
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-primary"))
                    }
                    .disabled(chatMessage.trimmingCharacters(in: .whitespacesAndNewlines) == ""
                              && selectedImage == nil )

                }
                .padding(.horizontal)
            }
            .frame(height: 76)
        }
      .onAppear {
        chatViewModel.getMessages()
        let ids = chatViewModel.getParticipantIds()
        self.participants = contactsViewModel.getParticipants(ids: ids)
      }
      .onDisappear {
        chatViewModel.conversationViewCleanup()
      }
      .confirmationDialog("From where?", isPresented: $isSourceDialogShowing, actions: {
        // show image Picker
        Button {
          self.source = .photoLibrary
          isPickerShowing = true
        } label: {
          Text("Photo Library")
        }
        // show user camera
        if UIImagePickerController.isSourceTypeAvailable(.camera){
        Button {
          self.source = .camera
          isPickerShowing = true
        } label: {
          Text("Take Photo")
        }
        }
        
      })
      .sheet(isPresented: $isPickerShowing) {
        ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, source: self.source)
      }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(isChatShowing: .constant(false))
    }
}
