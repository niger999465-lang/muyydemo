import SwiftUI

struct KeyVerificationView: View {
    @Binding var isUnlocked: Bool
    @State private var inputKey: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.black, Color.blue.opacity(0.3), Color.black], 
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                    Text("XÁC THỰC BẢN QUYỀN")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                    Text("Nhập Key do Admin (Python Server) cấp")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                VStack(spacing: 16) {
                    TextField("Nhập Key của bạn...", text: $inputKey)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .autocapitalization(.allCharacters)
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: {
                        verifyKeyWithPythonServer()
                    }) {
                        HStack {
                            if isLoading {
                                ProgressView().tint(.white)
                            } else {
                                Text("KÍCH HOẠT")
                                    .font(.headline.bold())
                            }
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                    .disabled(inputKey.isEmpty || isLoading)
                }
                .padding(.horizontal, 30)
            }
        }
    }
    
    func verifyKeyWithPythonServer() {
        isLoading = true
        errorMessage = ""
        
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? "unknown_device"
        let parameters: [String: Any] = ["key": inputKey, "device_id": deviceID]
        
        // Thay link này bằng link ngrok hoặc IP public từ máy nhà chạy Python script của bạn
        guard let url = URL(string: "https://your-python-server-tunnel.loca.lt/api/verify_key") else {
            isLoading = false
            errorMessage = "Đường dẫn URL Server không hợp lệ!"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                guard let data = data, error == nil else {
                    errorMessage = "Không thể kết nối đến máy chủ Python nhà bạn!"
                    return
                }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let success = json["success"] as? Bool {
                    if success {
                        UserDefaults.standard.set(true, forKey: "isKeyUnlocked")
                        isUnlocked = true
                    } else {
                        errorMessage = json["message"] as? String ?? "Key không hợp lệ!"
                    }
                } else {
                    errorMessage = "Phản hồi từ server không hợp lệ."
                }
            }
        }.resume()
    }
}