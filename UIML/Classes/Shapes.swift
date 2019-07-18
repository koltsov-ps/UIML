import Foundation
import UIKit

protocol Shape {
    func clip(view: UIView)
}

struct Circle: Shape {
    func clip(view: UIView) {
        view.layer.cornerRadius = floor(min(view.bounds.width / 2, view.bounds.height / 2))
    }
}
