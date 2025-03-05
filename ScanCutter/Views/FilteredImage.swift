import SwiftUI

struct FilteredImage: View {
    let image: UIImage
    
    var body: some View {
        GeometryReader { geometry in
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
        .aspectRatio(image.size.width / image.size.height, contentMode: .fit)
    }
}

// 预览提供者
struct FilteredImage_Previews: PreviewProvider {
    static var previews: some View {
        FilteredImage(
            image: UIImage(systemName: "doc.text.image")!
        )
        .padding()
    }
} 