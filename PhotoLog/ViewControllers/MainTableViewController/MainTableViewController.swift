
import UIKit
import expanding_collection

class MainTableViewController: ExpandingTableViewController {

    fileprivate var scrollOffsetY: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // 아이콘 변경 후 실행 시 에러 발생
//        configureNavBar()
        tableView.backgroundView = UIImageView(image: UIImage(named: "BackgroundImage"))
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        
        // 상단 이미지 높이 화면의 2/3 크기 설정
        headerHeight = UIScreen.main.bounds.size.height * (2/3)
    }
}

// MARK: Bind Data
extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        cell.contentLabel.text = "내용 입니다"
        return cell
    }
}

// MARK: Helpers
//extension MainTableViewController {
//    fileprivate func configureNavBar() {
//        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//        navigationItem.rightBarButtonItem?.image = navigationItem.rightBarButtonItem?.image!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//    }
//}

// MARK: Right Bar Button item Actions
extension MainTableViewController {

    @IBAction func backButtonHandler(_: AnyObject) {
        // Right Bar Button rotation Animation
//        let viewControllers: [MainViewController?] = navigationController?.viewControllers.map { $0 as? MainViewController } ?? []
//        for viewController in viewControllers {
//            if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
//                rightButton.animationSelected(false)
//            }
//        }
        popTransitionAnimation()
    }
}

// MARK: UIScrollViewDelegate (최상단에서 스크롤 내리면 뒤로가기 애니메이션)
//extension MainTableViewController {
//
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y < -25 , let navigationController = navigationController {
//            // Right Bar Button rotation Animation
//            for case let viewController as MainTableViewController in navigationController.viewControllers {
//                if case let rightButton as AnimatingBarButton = viewController.navigationItem.rightBarButtonItem {
//                    rightButton.animationSelected(false)
//                }
//            }
//            popTransitionAnimation()
//        }
//        scrollOffsetY = scrollView.contentOffset.y
//    }
//}
