import SwiftUI

public extension PUI {
    struct Picture: View {
        var url: URL?
        
        public init(_ url: URL?) {
            self.url = url
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
            } else {
                Color.pui.backgroundSecondary
            }
        }
    }
}
