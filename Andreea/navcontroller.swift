import UIKit

class navcontroller: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.shared.rootNavigationViewController = self
    }
}
