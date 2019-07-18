import Foundation
import UIKit

struct Layout {
    static func stripe(vertical: Bool, views: [UIView], margins: [UIEdgeInsets]) -> [NSLayoutConstraint] {
        var constaints = [NSLayoutConstraint]()
        let count = views.count
        guard count >= 2 else { return [] }
        for i in 0..<count-1 {
            constaints.append(
                vertical
                    ? NSLayoutConstraint(
                        item: views[i+1], attribute: .top,
                        relatedBy: .equal,
                        toItem: views[i], attribute: .bottom,
                        multiplier: 1,
                        constant: max(margins[i].bottom, margins[i+1].top))
                    : NSLayoutConstraint(
                        item: views[i+1], attribute: .leading,
                        relatedBy: .equal,
                        toItem: views[i], attribute: .trailing,
                        multiplier: 1,
                        constant: max(margins[i].right, margins[i+1].left))
            )
        }
        return constaints
    }
    
    static func arrange(view: UIView, in container: UIView, top: CGFloat? = nil, bottom: CGFloat? = nil, leading: CGFloat? = nil, trailing: CGFloat? = nil) -> [NSLayoutConstraint] {
        let margins: [(CGFloat?, NSLayoutConstraint.Attribute)] = [
            (top, .top),
            (bottom.map{ -$0 }, .bottom),
            (leading, .leading),
            (trailing.map{ -$0 }, .trailing)
        ]
        var constraints = [NSLayoutConstraint]()
        for (margin, attribute) in margins {
            guard let margin = margin else { continue }
            constraints.append(
                NSLayoutConstraint(
                    item: view, attribute: attribute,
                    relatedBy: .equal,
                    toItem: container, attribute: attribute,
                    multiplier: 1,
                    constant: margin)
            )
        }
        return constraints
    }
}

struct Spacer: UIViewRepresentable {
    func makeUIView() -> UIView {
        return UIView()
    }
}
