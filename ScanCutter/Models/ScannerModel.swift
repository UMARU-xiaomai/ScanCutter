import SwiftUI
import VisionKit

class ScannerModel: NSObject, ObservableObject {
    @Published var scannedImages: [UIImage] = []
    @State private var showCopyAlert = false
    
    func scanDocument() {
        let scannerViewController = VNDocumentCameraViewController()
        scannerViewController.delegate = self
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let viewController = windowScene.windows.first?.rootViewController {
            viewController.present(scannerViewController, animated: true)
        }
    }
}

extension ScannerModel: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        for pageIndex in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: pageIndex)
            scannedImages.append(image)
        }
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        print("Document camera view controller did fail with error: \(error)")
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
    }
} 