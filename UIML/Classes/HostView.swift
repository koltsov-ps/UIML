import Foundation
import UIKit

class HostView: UIView {
    var content: ViewBase? {
        didSet {
            guard let content = self.content else { return }
            render(content: content, in: self)
        }
    }
    
    func render(content: ViewBase, in container: UIView) {
        let (bodyView, marginsOrNil) = content.materialize()
        let margins = marginsOrNil ?? .zero
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bodyView)
        NSLayoutConstraint.activate(
            Layout.arrange(view: bodyView, in: self, top: margins.top, bottom: margins.bottom, leading: margins.left, trailing: margins.right)
        )
    }
}
