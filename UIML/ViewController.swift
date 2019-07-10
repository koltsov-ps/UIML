import UIKit

class ViewController: UIViewController {
    override func loadView() {
        let view = HostView()
        view.backgroundColor = .white
        
        view.content = VStack(
            views: [
                Text(
                    text: "Hello World 1",
                    textColor: .black,
                    margins: UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
                ),
                Text(
                    text: "Hello World 2",
                    textColor: .black,
                    margins: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
                )
            ],
            spacing: 0,
            margins: .zero
        )
        self.view = view
    }
}
