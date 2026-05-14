import SwiftUI

extension Image {
    init(imageName: String) {
        guard let uiImage = UIImage(named: imageName, in: Bundle(for: AccuChekUIController.self), compatibleWith: nil) else {
            fatalError("Image not found: \(imageName)")
        }

        self.init(uiImage: uiImage)
    }
}
