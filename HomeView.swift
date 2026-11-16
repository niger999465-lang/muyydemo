import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.opacity(0.2).ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        VStack(spacing: 4) {
                            Text("iHax").font(.system(size: 32, weight: .bold)).foregroundColor(.white)
                            Text("FF THƯỜNG // FF MAX").font(.caption).tracking(2).foregroundColor(.gray)
                        }
                        .padding(.top, 10)
                        
                        // Device Card
                        VStack(alignment: .leading, spacing: 12) {
                            HStack { Label("Model", systemImage: "iphone").foregroundColor(.white); Spacer(); Text("iPhone").foregroundColor(.gray) }
                            Divider().background(Color.white.opacity(0.2))
                            HStack { Label("Trạng thái", systemImage: "checkmark.shield").foregroundColor(.white); Spacer(); Text("Đã kích hoạt").foregroundColor(.green).bold() }
                        }
                        .padding().background(Color.white.opacity(0.12)).cornerRadius(18)
                        
                        // Key Protection Card
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Label("Key - Đang bảo vệ", systemImage: "key.fill").foregroundColor(.yellow).font(.subheadline.bold())
                                Spacer()
                            }
                            Divider().background(Color.white.opacity(0.2))
                            HStack { Text("Hạn Sử Dụng").foregroundColor(.white); Spacer(); Text("Không giới hạn").foregroundColor(.green).bold() }
                        }
                        .padding().background(Color.white.opacity(0.12)).cornerRadius(18)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
        }
    }
}