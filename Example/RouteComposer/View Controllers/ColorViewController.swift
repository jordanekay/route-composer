//
// Created by Eugene Kazaev on 19/12/2017.
//

import Foundation
import RouteComposer
import UIKit

class ColorViewControllerFinder: StackIteratingFinder {

    typealias ViewController = ColorViewController

    typealias Context = String

    public let iterator: StackIterator = DefaultStackIterator(options: .currentAllStack)

    func isTarget(_ viewController: ColorViewController, with colorHex: String) -> Bool {
        viewController.colorHex = colorHex
        return true
    }

}

class ColorViewControllerFactory: Factory {

    typealias ViewController = ColorViewController

    typealias Context = String

    init() {}

    func build(with colorHex: String) throws -> ColorViewController {
        let colorViewController = ColorViewController(nibName: nil, bundle: nil)
        colorViewController.colorHex = colorHex

        return colorViewController
    }

}

class ColorViewController: UIViewController, DismissibleWithRuntimeStorage, ExampleAnalyticsSupport {

    typealias DismissalTargetContext = Void

    let screenType = ExampleScreenTypes.color

    typealias ColorDisplayModel = String

    var colorHex: ColorDisplayModel? {
        didSet {
            if let colorHex = colorHex, isViewLoaded {
                self.view.backgroundColor = UIColor(hexString: colorHex)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "colorViewController"
        title = "Color"
        if let colorHex = colorHex {
            view.backgroundColor = UIColor(hexString: colorHex)
        } else {
            view.backgroundColor = UIColor.white
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
    }

    @objc func doneTapped() {
        dismissViewController(animated: true)
    }

}
