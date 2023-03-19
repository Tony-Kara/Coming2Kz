import SwiftUI

struct ConversationView: View {
  
  @EnvironmentObject var chatViewModel: ChatViewModel
  @EnvironmentObject var contactsViewModel: ContactsViewModel
  @Binding var isChatShowing: Bool
  
  @State var selectedImage: UIImage?
  @State var isPickerShowing = false
  @State var isSourceDialogShowing = false
  @State var isSContactsPickerShowing = false
  @State var source: UIImagePickerController.SourceType = .photoLibrary
  
  @State var chatMessage = ""
  @State var participants = [User]()
  
  var body: some View {
    
    ZStack {
      Color("backgroundc")
        .ignoresSafeArea()
      VStack (spacing: 0) {
        
        // Chat header
        ZStack {
          Color(.white)
          HStack {
            VStack (alignment: .leading) {
              
              HStack {
                
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
                
                if participants.count == 0 {
                  Text("New Message")
                    .customFont(.headline)
                    .foregroundColor(Color("text-header"))
                }
                
                
              }.padding(.bottom, 16)
              
              // Name
              if participants.count > 0 {
                let participant = participants.first
             //   Group {
                  
                  if participants.count == 1 {
                    Text("\(participant?.firstname ?? "") \(participant?.lastname ?? "")")
                      .customFont(.headline)
                      .foregroundColor(Color("text-header"))
                  }
                  else if participants.count == 2 {
                    
                    let participant2 = participants[1]
                    
                    Text("\(participant?.firstname ?? ""),  \(participant2.firstname ?? "")")
                      .customFont(.headline)
                      .foregroundColor(Color("text-header"))
                  }
                  
                  else if participants.count > 2 {
                    
                    let participant2 = participants[1]
                    
                    Text("\(participant?.firstname ?? ""),  \(participant2.firstname ?? "") + \(participants.count - 2) others")
                      .customFont(.headline)
                      .foregroundColor(Color("text-header"))
                  }
             //   }
               
                
                
                
              }
              else {
                Text("Recipients")
                  .customFont(.subheadline)
                  .foregroundColor(Color("text-input"))
              }
              
            }
            
            Spacer()
            
            // Profile image
            if participants.count == 1 {
              let participant = participants.first
              ProfilePicView(user: participant!)
            }
            else if participants.count > 1 {
              GroupProfilePicView(users: participants)
            }
            else {
              Button {
                isSContactsPickerShowing = true
              } label: {
                
                Image(systemName: "plus.circle.fill")
                  .resizable()
                  .frame(width:25, height: 25)
                  .foregroundColor(Color("button-primary"))
              }
              
            }
          }
          .padding(.horizontal)
          
        }.frame(height: 104)
        
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
                    ConversationPhotoMessage(imageUrl: msg.imageurl!,
                                             isFromUser: isFromUser)
                  }
                  else {
                    ConversationTextMessage(msg: msg.msg,
                                            isFromUser: isFromUser)
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
          .onChange(of: chatViewModel.messages.count) { newCount in
            withAnimation {
              proxy.scrollTo(newCount - 1)
            }
            
          }
        }
        // Chat message bar
        
        
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
        .disabled(participants.count == 0)
        .padding(.horizontal)
        .frame(height: 76)
      }
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
    .sheet(isPresented: $isSContactsPickerShowing) {
      
      chatViewModel.getChatFor(contacts: participants)
      
    } content: {
      ContactsPicker(isContactsPickerShowing: $isSContactsPickerShowing, selectedContacts: self.$participants)
    }
    
  }
}

struct ConversationView_Previews: PreviewProvider {
  static var previews: some View {
    ConversationView(isChatShowing: .constant(false))
  }
}
