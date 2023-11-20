
import SwiftUI

struct ContentView: View {
    @State private var selection: String? = "Home"
    
    var body: some View {
        NavigationView {
            List(selection: $selection) {
                Section(header: Text("Section 1")) {
                    NavigationLink(
                        destination: HomeView(),
                        tag: "Home",
                        selection: $selection,
                        label: {
                            Label("Home", systemImage: "house")
                        }
                    )
                    
                    NavigationLink(
                        destination: ProfileView(),
                        tag: "Profile",
                        selection: $selection,
                        label: {
                            Label("Profile", systemImage: "person")
                        }
                    )
                }
                
                Section(header: Text("Section 2")) {
                    NavigationLink(
                        destination: SettingsView(),
                        tag: "Settings",
                        selection: $selection,
                        label: {
                            Label("Settings", systemImage: "gear")
                        }
                    )
                    
                    NavigationLink(
                        destination: HelpView(),
                        tag: "Help",
                        selection: $selection,
                        label: {
                            Label("Help", systemImage: "questionmark.circle")
                        }
                    )
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 200) // 设置侧边栏的宽度
            
            Text("Select an option")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(minWidth: 800, minHeight: 600) // 设置窗口的最小尺寸

    }
}

struct HomeView: View {
    var body: some View {
        Text("Home")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct HelpView: View {
    var body: some View {
        Text("Help")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
