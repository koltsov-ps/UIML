import Foundation
import UIKit

struct HStack: UIViewRepresentable {
    let views: [ViewBase]
    var spacing: CGFloat?
    
    init(spacing: CGFloat? = nil, _ views: [ViewBase]) {
        self.spacing = spacing
        self.views = views
    }
    
    func makeUIView() -> UIView {
        let view = BasicView()
        layout(in: view)
        return view
    }
    
    func layout(in container: UIView) {
        let vm = views.map { $0.materialize() }
        let bodies = vm.map { $0.0 }
        let margins = vm.map { $0.1 ?? .zero }
        for body in bodies {
            body.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(body)
        }
        NSLayoutConstraint.activate(
            Layout.stripe(
                vertical: false,
                views: bodies,
                margins: margins))
        if let first = bodies.first,
            let margins = margins.first {
            NSLayoutConstraint.activate(
                Layout.arrange(view: first, in: container, leading: margins.left))
        }
        if let last = bodies.last,
            let margins = margins.last {
            NSLayoutConstraint.activate(
                Layout.arrange(view: last, in: container, trailing: margins.right))
            last.setContentHuggingPriority(.init(100), for: .horizontal)
            last.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
        for i in 0..<bodies.count {
            let margins = margins[i]
            NSLayoutConstraint.activate(
                Layout.arrange(view: bodies[i], in: container, top: margins.top, bottom: margins.bottom))
        }
    }
}

