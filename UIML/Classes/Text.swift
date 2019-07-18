import Foundation
import UIKit

struct Text: UIViewRepresentable {
    var text: String?
    var textColor: UIColor = .black
    var textStyle: UIFont.TextStyle?
    var textAlignment: NSTextAlignment = .center
    var numberOfLines: Int = 1
    init(_ text: String) {
        self.text = text
    }
    
    func color(_ textColor: UIColor) -> Text {
        var copy = self
        copy.textColor = textColor
        return copy
    }
    
    func font(_ textStyle: UIFont.TextStyle) -> Text {
        var copy = self
        copy.textStyle = textStyle
        return copy
    }
    
    func alignment(_ textAlignment: NSTextAlignment) -> Text {
        var copy = self
        copy.textAlignment = textAlignment
        return copy
    }
    
    func lineLimit(_ numberOfLines: Int) -> Text {
        var copy = self
        copy.numberOfLines = numberOfLines
        return copy
    }
    
    func makeUIView() -> UIView {
        let label = UIMLLabel()
        label.text = text
        label.textColor = textColor
        if let style = self.textStyle {
            label.font = UIFont.preferredFont(forTextStyle: style)
        }
        label.textAlignment = self.textAlignment
        label.numberOfLines = numberOfLines
        return label
    }
}

protocol UIMLView: AnyObject {
    var clipShape: Shape? { get set }
}

class UIMLLabel: UILabel, UIMLView {
    var clipShape: Shape?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipShape?.clip(view: self)
    }
}

class BasicView: UIView, UIMLView {
    var clipShape: Shape?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipShape?.clip(view: self)
    }
}

class UIMLImageView: UIImageView, UIMLView {
    var clipShape: Shape?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipShape?.clip(view: self)
    }
}
