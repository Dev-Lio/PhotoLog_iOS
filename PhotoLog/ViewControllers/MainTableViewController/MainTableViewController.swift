
import UIKit
import expanding_collection

class MainTableViewController: ExpandingTableViewController {

    fileprivate var scrollOffsetY: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        tableView.backgroundView = UIImageView(image: UIImage(named: "BackgroundImage"))
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }
}

// MARK: Helpers

extension MainTableViewController {

    fileprivate func configureNavBar() {
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        navigationItem.rightBarButtonItem?.image = navigationItem.rightBarButtonItem?.image!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    }
}

// MARK: Actions

extension MainTableViewController {

    @IBAction func backButtonHandler(_: AnyObject) {
        // buttonAnimation
        let viewControllers: [MainViewController?] = navigationController?.viewControllers.map { $0 as? MainViewController } ?? []

        for viewController in viewControllers {
            if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(false)
            }
        }
        popTransitionAnimation()
    }
}

// MARK: UIScrollViewDelegate

extension MainTableViewController {

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -25 , let navigationController = navigationController {
            // buttonAnimation
            for case let viewController as MainViewController in navigationController.viewControllers {
                if case let rightButton as AnimatingBarButton = viewController.navigationItem.rightBarButtonItem {
                    rightButton.animationSelected(false)
                }
            }
            popTransitionAnimation()
        }
        scrollOffsetY = scrollView.contentOffset.y
    }
}