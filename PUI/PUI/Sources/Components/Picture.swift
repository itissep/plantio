import SwiftUI

public extension PUI {
    struct Picture: View {
        var url: URL?
        var data: Data?
        
        public init(_ url: URL?, data: Data?) {
            self.url = url
            self.data = data
        }
        
        public var body: some View {
            if let url {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            Color.pui.backgroundSecondary
                            ProgressView()
                                .tint(Color.pui.accent)
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure(_):
                        ZStack {
                            Color.pui.backgroundSecondary
                            Image(systemName: "photo.fill")
                                .font(.title)
                                .tint(Color.pui.accent)
                        }
                    default:
                        Color.pui.backgroundSecondary
                    }
                }
            } else if let data, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.pui.backgroundSecondary
            }
        }
    }
}
