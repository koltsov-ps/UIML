import Foundation
import UIKit

protocol ViewBase { }

protocol View: ViewBase {
    var body: View { get }
    
    var margins: UIEdgeInsets { get }
}

protocol UIViewRepresentable: ViewBase {
    func makeUIView() -> UIView
    
    var margins: UIEdgeInsets { get }
}
