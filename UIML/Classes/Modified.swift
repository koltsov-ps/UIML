import Foundation
import UIKit

protocol LayoutProps {
    var marginsInfo: UIEdgeInsets? { get }
    func apply(to: UIView)
}

struct Modified<T: ViewBase>: View, LayoutProps {
    var inner: T
    
    var borderInfo: Border?
    var marginsInfo: UIEdgeInsets?
    var contentModeInfo: UIView.ContentMode?
    var backgroundColor: UIColor?
    
    var width: CGFloat?
    var height: CGFloat?
    
    var clipShape: Shape?
    
    init(_ inner: T) {
        self.inner = inner
    }
    
    var body: View {
        //TODO
        return self.inner as! View
    }
    
    func apply(to view: UIView) {
        borderInfo?.apply(to: view)
        if let contentMode = self.contentModeInfo {
            view.contentMode = contentMode
        }
        if let backgroundColor = self.backgroundColor {
            view.backgroundColor = backgroundColor
        }
        if let width = self.width {
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: width)
            ])
        }
        if let height = self.height {
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: height)
            ])
        }
        if let clipShape = self.clipShape,
           let view = view as? UIMLView {
            view.clipShape = clipShape
        }
    }
}

struct Border {
    let width: CGFloat
    let color: UIColor
    
    func apply(to view: UIView) {
        view.layer.borderWidth = width
        view.layer.borderColor = color.cgColor
    }
}

extension ViewBase {
    func border(width: CGFloat, color: UIColor) -> Modified<Self> {
        var m = Modified(self)
        return m.border(width: width, color: color)
    }
    
    func margins(_ marginsInfo: UIEdgeInsets) -> Modified<Self> {
        var m = Modified(self)
        return m.margins(marginsInfo)
    }
    
    func contentMode(_ contentMode: UIView.ContentMode) -> Modified<Self> {
        var m = Modified(self)
        return m.contentMode(contentMode)
    }
    
    func background(color: UIColor) -> Modified<Self> {
        var m = Modified(self)
        return m.background(color: color)
    }
    
    func frame(width: CGFloat?, height: CGFloat?) -> Modified<Self> {
        var m = Modified(self)
        return m.frame(width: width, height: height)
    }
    
    func clip(to shape: Shape) -> Modified<Self> {
        var m = Modified(self)
        return m.clip(to: shape)
    }
}

extension Modified {
    mutating func border(width: CGFloat, color: UIColor) -> Modified {
        self.borderInfo = Border(width: width, color: color)
        return self
    }
    
    mutating func margins(_ marginsInfo: UIEdgeInsets) -> Modified {
        self.marginsInfo = marginsInfo
        return self
    }
    
    mutating func contentMode(_ contentMode: UIView.ContentMode) -> Modified {
        self.contentModeInfo = contentMode
        return self
    }
    
    mutating func background(color: UIColor) -> Modified {
        self.backgroundColor = color
        return self
    }
    
    mutating func frame(width: CGFloat?, height: CGFloat?) -> Modified {
        self.width = width
        self.height = height
        return self
    }
    
    mutating func clip(to shape: Shape) -> Modified {
        self.clipShape = shape
        return self
    }
}
