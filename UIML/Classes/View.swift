import Foundation
import UIKit

protocol ViewBase { }

protocol View: ViewBase {
    var body: View { get }
}

protocol UIViewRepresentable: View {
    func makeUIView() -> UIView
}

extension UIViewRepresentable {
    var body: View { fatalError("Not Implemented") }
}
