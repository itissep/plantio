import SwiftUI
import PUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var selectedItem: Int? = nil
        
        var body: some View {
            TabView(selection: $selectedTab) {
                FirstScreen()
                    .tabItem { PUI.TabLabel("Feed", Image(systemName: "square.stack.fill")) }
                    .tag(0)
                
                SecondScreen(selectedItem: $selectedItem)
                    .tabItem { PUI.TabLabel("Search", Image(systemName: "sparkle.magnifyingglass")) }
                    .tag(1)
                
                ThirdScreen()
                    .tabItem { PUI.TabLabel("Plants", Image(systemName: "leaf.fill")) }
                    .tag(3)
            }
        }
}


struct FirstScreen: View {
    var body: some View {
        Text("Feed")
    }
}

struct SecondScreen: View {
    @Binding var selectedItem: Int?
    
    var body: some View {
        Text("Search")
    }
}
struct ThirdScreen: View {
    var body: some View {
        Text("Plants")
    }
}
