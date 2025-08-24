import SwiftUI

struct ProfileContentView: View {
    // MARK: - Properties
    @StateObject private var viewModel: ProfileViewModel
    @State private var isChangeUserPhoto = false
    @State private var profileImageName = "avatar9"
    
    // MARK: - Constants
    private enum Drawing {
        static let profileImageSize: CGFloat = 135
        static let blurRadius: CGFloat = 5
        static let sectionSpacing: CGFloat = 20
        static let bottomPadding: CGFloat = 20
        static let changePhotoViewHeight: CGFloat = 350
    }
    
    //    MARK: - INIT
    init() {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel())
    }
    
    //    MARK: - BODY
    var body: some View {
        ZStack {
            Color(.appBackground)
                .ignoresSafeArea(.all)
            .onTapGesture {
                isChangeUserPhoto = false
            }
            
            VStack(alignment: .leading, spacing: Drawing.sectionSpacing) {
            HStack {
                    profileImageView
                    .padding()
                Text(viewModel.userName)
                    .recipesTitleStyle()
                Spacer()
                }
                Spacer()
            }
            .blur(radius: isChangeUserPhoto ? Drawing.blurRadius : 0)
            // MARK: - Change Photo View
            if isChangeUserPhoto {
                changePhotoOverlay
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var changePhotoOverlay: some View {
        return ChangePhotoView(selectedAvatar: $profileImageName)
            .frame(height: Drawing.changePhotoViewHeight)
    }
}
// MARK: - Subviews
extension ProfileContentView {
    private var profileImageView: some View {
        Image(profileImageName)
            .resizable()
            .scaledToFill()
            .frame(width: Drawing.profileImageSize, height: Drawing.profileImageSize)
            .clipShape(Circle())
            .onTapGesture {
                isChangeUserPhoto.toggle()
            }
    }
    
}
#Preview {
    ProfileContentView()
}
