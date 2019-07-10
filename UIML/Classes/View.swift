import Foundation
import UIKit

protocol View {
    //TODO: make views composable
    var body: UIView { get }
    
    var margins: UIEdgeInsets { get }
}
