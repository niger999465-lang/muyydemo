import SwiftUI

struct ContentView: View {
    @AppStorage("hasCustomWallpaper") private var hasCustomWallpaper = false
    @State private var backgroundUIImage: UIImage? = nil
    
    var body: some View {
        ZStack {
            // Lớp hình nền tùy chỉnh hoặc nền tối mặc định
            if hasCustomWallpaper, let bgImage = backgroundUIImage {
                Image(uiImage: bgImage)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.5))
            } else {
                LinearGradient(colors: [Color.black, Color.purple.opacity(0.2), Color.black], 
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            }
            
            // Tab Bar điều hướng các màn hình
            TabView {
                HomeView()
                    .tabItem {
                        Label("Trang chủ", systemImage: "house.fill")
                    }
                
                FunctionsView()
                    .tabItem {
                        Label("Chức năng", systemImage: "cube.box.fill")
                    }
                
                WallpaperLabView()
                    .tabItem {
                        Label("Hình nền", systemImage: "photo.fill")
                    }
                
                SettingsView()
                    .tabItem {
                        Label("Cài đặt", systemImage: "gearshape.fill")
                    }
            }
            .accentColor(.blue)
        }
        .preferredColorScheme(.dark)
        .onAppear { loadBackground() }
        .onChange(of: hasCustomWallpaper) { _ in loadBackground() }
    }
    
    func loadBackground() {
        let filename = getDocumentsDirectory().appendingPathComponent("custom_wallpaper.jpg")
        if let data = try? Data(contentsOf: filename), let uiImage = UIImage(data: data) {
            backgroundUIImage = uiImage
        } else {
            backgroundUIImage = nil
        }
    }
    
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}