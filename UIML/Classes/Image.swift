import Foundation
import UIKit

struct Image: UIViewRepresentable {
    let image: UIImage
    init(_ image: UIImage) {
        self.image = image
    }
    
    func makeUIView() -> UIView {
        let view = UIMLImageView()
        view.image = self.image
        view.clipsToBounds = true
        return view
    }
}
