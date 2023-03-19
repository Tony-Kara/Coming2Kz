
import SwiftUI

struct ContactRow: View {
  
  var user: User
  
  var body: some View {
    
    HStack (spacing: 24) {
      
      ProfilePicView(user: user)
      
      VStack (alignment: .leading, spacing: 4) {
        // Name
        Text("\(user.firstname ?? "") \(user.lastname ?? "")")
          .customFont(.subheadline2)
          .foregroundColor(Color("text-primary"))
        
        Text(user.phone ?? "")
          .customFont(.subheadline)
          .foregroundColor(Color("text-input"))
      }
      
      Spacer()
    }
  }
}

struct ContactRow_Previews: PreviewProvider {
  static var previews: some View {
    ContactRow(user: User())
  }
}
