import Foundation
import UIKit

extension View {
    mutating func border(width: CGFloat, color: UIColor) -> Modified<Self> {
        var m = Modified(self)
        return m.border(width: width, color: color)
    }
}

extension Modified {
    mutating func border(width: CGFloat, color: UIColor) -> Modified {
        self.borderInfo = Border(width: width, color: color)
        return self
    }
}

struct Modified<T: View>: View {
    var inner: T
    
    var borderInfo: Border?
    var margins: UIEdgeInsets = .zero
    
    init(_ inner: T) {
        self.inner = inner
    }
    
    var body: UIView {
        return inner.body
    }
}

struct Border {
    let width: CGFloat
    let color: UIColor
}

struct Text: View {
    var text: String?
    var textColor: UIColor = .black
    var margins: UIEdgeInsets = .zero
    
//    init(_ text: String) {
//        self.text = text
//    }
    
    mutating func color(_ textColor: UIColor) -> Text {
        self.textColor = textColor
        return self
    }
    
    var body: UIView {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.textAlignment = .center
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 1
        return label
    }
}

struct Layout {
    static func stripe(vertical: Bool, views: [UIView], margins: [UIEdgeInsets]) -> [NSLayoutConstraint] {
        var constaints = [NSLayoutConstraint]()
        let count = views.count
        guard count >= 2 else { return [] }
        for i in 0..<count-1 {
            constaints.append(
                vertical
                    ? NSLayoutConstraint(
                        item: views[i+1], attribute: .bottom,
                        relatedBy: .equal,
                        toItem: views[i], attribute: .top,
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


struct VStack: View {
    let views: [View]
    var spacing: CGFloat
    var margins: UIEdgeInsets
    
    var body: UIView {
        let view = UIView()
        view.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        layout(in: view)
        return view
    }
    
    func layout(in container: UIView) {
        let bodies = views.map { $0.body }
        for body in bodies {
            body.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(body)
        }
        NSLayoutConstraint.activate(
            Layout.stripe(
                vertical: true,
                views: bodies,
                margins: views.map { $0.margins }))
        if let first = bodies.first,
            let margins = views.first?.margins {
            NSLayoutConstraint.activate(
                Layout.arrange(view: first, in: container, top: margins.top))
        }
        if let last = bodies.last,
            let margins = views.last?.margins {
            NSLayoutConstraint.activate(
                Layout.arrange(view: last, in: container, bottom: margins.bottom))
            last.setContentHuggingPriority(.init(100), for: .vertical)
            last.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        }
        for i in 0..<bodies.count {
            let margins = views[i].margins
            NSLayoutConstraint.activate(
                Layout.arrange(view: bodies[i], in: container, leading: margins.left, trailing: margins.right))
        }
    }
}



class HostView: UIView {
    var content: View? {
        didSet {
            guard let content = self.content else { return }
            render(content: content, in: self)
        }
    }
    
    func render(content: View, in container: UIView) {
        let bodyView = content.body
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bodyView)
        let margins = content.margins
        NSLayoutConstraint.activate(
            Layout.arrange(view: bodyView, in: self, top: margins.top, bottom: margins.bottom, leading: margins.left, trailing: margins.right)
        )
        
        bodyView.layer.borderColor = UIColor.blue.cgColor
        bodyView.layer.borderWidth = 1
    }
}
