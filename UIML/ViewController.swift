import UIKit

class ViewController: UIViewController {
    override func loadView() {
        let view = HostView()
        view.backgroundColor = .white
        view.content = VStack([
            Text("Title 1 (red)")
                .color(.red)
                .font(.title1)
                .margins(UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 8))
                .border(width: 1, color: .red),
            Text("Body (white)")
                .color(.white)
                .font(.body)
                .background(color: .blue)
                .margins(UIEdgeInsets(top: 8, left: 15, bottom: 0, right: 8)),
            HStack([
                Text("body")
                    .font(.body),
                Text("callout")
                    .font(.callout)
                    .color(.lightGray)
                    .alignment(.left)
                    .border(width: 1, color: .lightGray)
            ])
                .margins(UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)),
            UserRow(),
            RichTextContent()
                .margins(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)),
            Spacer()
        ])
        self.view = view
    }
}

struct UserRow: View {
    var body: View {
        return HStack([
            Image(UIImage(named: "UserPic")!)
                .contentMode(.scaleAspectFill)
                .frame(width: 40, height: 40)
                .clip(to: Circle()),
            VStack([
                Text("User name")
                    .font(.body)
                    .alignment(.left)
                    .color(.darkGray),
                Text("Description")
                    .font(.callout)
                    .alignment(.left)
                    .color(.lightGray)
            ])
                .margins(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0))
        ])
            .margins(UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
    }
}

struct H1: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: View {
        return Text(text)
            .font(.largeTitle)
            .alignment(.left)
            .lineLimit(0)
            .margins(UIEdgeInsets(top: 20, left: 0, bottom: 15, right: 0))
    }
}

struct P: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: View {
        return Text(text)
            .font(.body)
            .alignment(.left)
            .lineLimit(0)
            .margins(UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }
}

struct RichTextContent: View {
    var body: View {
        return VStack([
            H1("Lorem ipsum dolor sit amet"),
            P("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
            P("Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
        ])
    }
}
