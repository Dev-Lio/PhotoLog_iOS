
import UIKit
import expanding_collection

class MainTableViewController: ExpandingTableViewController {

    fileprivate var scrollOffsetY: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // 아이콘 변경 후 실행 시 에러 발생
//        configureNavBar()
        registerCell()
        setHeight()
        tableView.backgroundView = UIImageView(image: UIImage(named: "BackgroundImage"))
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }

        // 헤더 뷰의 컨텍스트를 가져와서 터치 이벤트를 걸어줘야 한다
        // Initialize Tap Gesture Recognizer
         let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
         // Add Tap Gesture Recognizer
//        getHeaderView()?.addGestureRecognizer(tapGestureRecognizer)
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func headerTapped() {
           print("Header tapped")
       }
}

// MARK: Bind Data
extension MainTableViewController {
    
    func setHeight(){
        // 상단 이미지 높이 화면 크기만큼 조절
        headerHeight = UIScreen.main.bounds.size.height
        // 테이블 뷰 셀 높이 자동 설정
        tableView.estimatedRowHeight = 80
    }
    
    fileprivate func registerCell(){
        let nib = UINib(nibName: String(describing: DetailTableViewCell.self), bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: String(describing: DetailTableViewCell.self))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        let introduction = NSAttributedString(string: "행 높이의 음수가 아닌 추정치를 제공하면 테이블보기로드 성능을 향상시킬 수 있습니다. 테이블에 가변 높이 행이 포함 된 경우 테이블이로드 될 때 모든 높이를 계산하는 데 비용이 많이들 수 있습니다. 추정을 사용하면로드 시간에서 스크롤링 시간까지 기하학 계산 비용의 일부를 연기 할 수 있습니다. 기본값은 automaticDimension이며, 이는 테이블보기가 사용자 대신 사용할 예상 높이를 선택 함을 의미합니다. 값을 0으로 설정하면 예상 높이가 비활성화되어 테이블 뷰가 각 셀의 실제 높이를 요청하게됩니다. 테이블에서 자체 크기 조정 셀을 사용하는 경우이 속성의 값은 0이 아니어야합니다. 높이 추정을 사용할 때 테이블보기는 스크롤보기에서 상속 된 contentOffset 및 contentSize 속성을 적극적으로 관리합니다. 이러한 속성을 직접 읽거나 수정하지 마십시오.").withLineSpacing(10)
        cell.contentLabel.attributedText = introduction
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    // 테이블 뷰 셀 높이 자동 설정
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
        let viewControllers: [MainViewController?] = navigationController?.viewControllers.map { $0 as? MainViewController } ?? []
        for viewController in viewControllers {
            if let leftButton = viewController?.navigationItem.leftBarButtonItem as? AnimatingBarButton {
                leftButton.animationSelected(false)
            }
        }
        popTransitionAnimation()
    }
}

// MARK: UIScrollViewDelegate (최상단에서 스크롤 내리면 뒤로가기)
extension MainTableViewController {

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -25 , let navigationController = navigationController {
            // Right Bar Button rotation Animation
            for case let viewController as MainTableViewController in navigationController.viewControllers {
                if case let leftButton as AnimatingBarButton = viewController.navigationItem.leftBarButtonItem {
                    leftButton.animationSelected(false)
                }
            }
            popTransitionAnimation()
        }
        scrollOffsetY = scrollView.contentOffset.y
    }
}

// MARK: Add line spacing to cell label
extension NSAttributedString {
    func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                        value: paragraphStyle,
                                        range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }
}
