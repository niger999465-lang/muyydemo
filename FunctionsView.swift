import SwiftUI

struct FunctionsView: View {
    @State private var selectedGame: GameType = .normal
    @State private var selectedFeature: FeatureType = .aim
    
    enum GameType { case normal, max }
    enum FeatureType { case aim, menu, mod, holo }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.opacity(0.2).ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 18) {
                        HStack {
                            Text("Đang chờ thao tác patch...").font(.caption).foregroundColor(.gray)
                            Spacer()
                            Button("Đồng bộ") {}
                            .font(.caption.bold()).foregroundColor(.white).padding(8)
                            .background(Color.blue.opacity(0.4)).cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        // Game Selector
                        HStack(spacing: 14) {
                            GameCard(title: "FF THƯỜNG", bundleId: "com.dts.freefireth", isSelected: selectedGame == .normal) { selectedGame = .normal }
                            GameCard(title: "FF MAX", bundleId: "com.dts.freefiremax", isSelected: selectedGame == .max) { selectedGame = .max }
                        }
                        .padding(.horizontal)
                        
                        // Feature Grid
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                            FeatureGridCard(title: "AIM", subtitle: "Patch AIM", icon: "scope", isSelected: selectedFeature == .aim) { selectedFeature = .aim }
                            FeatureGridCard(title: "MENU", subtitle: "Patch MENU", icon: "slider.horizontal.3", isSelected: selectedFeature == .menu) { selectedFeature = .menu }
                            FeatureGridCard(title: "MOD", subtitle: "Patch MOD", icon: "cube.box", isSelected: selectedFeature == .mod) { selectedFeature = .mod }
                            FeatureGridCard(title: "HOLO", subtitle: "Patch HOLO", icon: "sparkles", isSelected: selectedFeature == .holo) { selectedFeature = .holo }
                        }
                        .padding(.horizontal)
                        
                        Button(action: {}) {
                            Text("MỞ APP").font(.headline.bold()).foregroundColor(.white)
                                .frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(16)
                        }
                        .padding(.horizontal).padding(.top, 10)
                    }
                    .padding(.top, 10)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct GameCard: View {
    let title: String, bundleId: String, isSelected: Bool, action: () -> Void
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title).font(.headline.bold()).foregroundColor(.white)
                Text(bundleId).font(.system(size: 9)).foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading).padding()
            .background(Color.white.opacity(isSelected ? 0.2 : 0.08)).cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2))
        }
    }
}

struct FeatureGridCard: View {
    let title: String, subtitle: String, icon: String, isSelected: Bool, action: () -> Void
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: icon).font(.title2).foregroundColor(isSelected ? .blue : .white)
                Text(title).font(.headline.bold()).foregroundColor(.white)
                Text(subtitle).font(.caption2).foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading).padding()
            .background(Color.white.opacity(isSelected ? 0.2 : 0.08)).cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(isSelected ? Color.blue : Color.clear, lineWidth: 1.5))
        }
    }
}