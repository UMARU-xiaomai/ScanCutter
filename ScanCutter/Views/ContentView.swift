import SwiftUI

struct ContentView: View {
    @StateObject private var scannerModel = ScannerModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if !scannerModel.scannedImages.isEmpty {
                    DocumentEditView(images: scannerModel.scannedImages,
                                  scannerModel: scannerModel)
                } else {
                    ScannerStartView(scannerModel: scannerModel)
                }
            }
            .navigationTitle("扫描文档")
            .toolbar {
                if !scannerModel.scannedImages.isEmpty {
                    Button(action: {
                        scannerModel.scanDocument()
                    }) {
                        Text("继续添加")
                    }
                }
            }
        }
    }
}

struct ScannerStartView: View {
    let scannerModel: ScannerModel
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.viewfinder")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("点击开始扫描文档")
                .font(.title2)
            
            Button(action: {
                scannerModel.scanDocument()
            }) {
                Text("开始扫描")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
} 