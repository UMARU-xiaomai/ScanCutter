import SwiftUI

struct DocumentEditView: View {
    let images: [UIImage]
    @ObservedObject var scannerModel: ScannerModel
    @State private var showCopyAlert = false
    @State private var copiedImageIndex: Int?
    @State private var showClearAlert = false
    
    
    private let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 10)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<images.count, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.1))
                        
                        Image(uiImage: images[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 150, minHeight: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack {
                            Spacer()
                            HStack {
                                Text("\(index + 1)")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(Color.black.opacity(0.5))
                                    .cornerRadius(4)
                                    .padding(4)
                                Spacer()
                            }
                        }
                    }
                    .onTapGesture {
                        UIPasteboard.general.image = images[index]
                        copiedImageIndex = index
                        showCopyAlert = true
                    }
                }
            }
            .padding()
            Button(action: {
                showClearAlert = true
            }) {
                Text("返回")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(minWidth: 80)
                    .background(Color.gray)
                    .cornerRadius(10)
            }
            .alert("确认清除", isPresented: $showClearAlert) {
                Button("取消", role: .cancel) {}
                Button("确定", role: .destructive) {
                    scannerModel.scannedImages.removeAll()
                }
            } message: {
                Text("这将清除所有已扫描的图片")
            }
        }
        .alert("已复制到剪贴板", isPresented: $showCopyAlert) {
            Button("确定", role: .cancel) { }
        } message: {
            if let index = copiedImageIndex {
                Text("第 \(index + 1) 张图片已复制")
            }
        }
    }
}
