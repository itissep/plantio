import SwiftUI
import PUI

struct ContentView: View {
    var body: some View {
        TabView {
            List(PUI.Font.all, id: \.title) { font in
                Text(font.title.capitalized).font(font.font)
            }
            .tabItem { PUI.TabLabel("Fonts", Image(systemName: "textformat.size.smaller")) }
            
            List(PUI.Color.all, id: \.title) { color in
                HStack {
                    RoundedRectangle(cornerRadius: PUI.Constant.cornerRadius)
                        .foregroundColor(color.color)
                        .frame(width: 30, height: 30)
                    Text(color.title)
                    Spacer()
                }
            }
            .tabItem { PUI.TabLabel("Colors", Image(systemName: "circlebadge.2.fill")) }
        }
    }
}

#Preview {
    ContentView()
}
