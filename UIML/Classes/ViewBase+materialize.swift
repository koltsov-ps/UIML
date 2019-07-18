import Foundation
import UIKit

extension ViewBase {
    func materialize() -> (UIView, UIEdgeInsets?) {
        
        let props = self as? LayoutProps
        let margins = props?.marginsInfo
        
        if let view = self as? UIViewRepresentable {
            let uiView = view.makeUIView()
            
            props?.apply(to: uiView)
            
            return (uiView, margins)
        }
        if let view = self as? View {
            let (uiView, childMargins) = view.body.materialize()
            
            props?.apply(to: uiView)
            
            let resultMargins: UIEdgeInsets?
            if margins != nil || childMargins != nil {
                let m = margins ?? .zero
                let c = childMargins ?? .zero
                resultMargins = UIEdgeInsets(
                    top: m.top + c.top,
                    left: m.left + c.left,
                    bottom: m.bottom + c.bottom,
                    right: m.right + c.right)
            }
            else {
                resultMargins = nil
            }
            return (uiView, resultMargins)
        }
        fatalError("Unknown subtype")
    }
}
