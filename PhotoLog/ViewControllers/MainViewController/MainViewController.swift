
import UIKit
import expanding_collection

class MainViewController: ExpandingViewController {

    typealias ItemInfo = (imageName: String, title: String, content: String)
    fileprivate var cellsIsOpen = [Bool]()
    fileprivate let items: [ItemInfo] = [
        ("item0", "2022", "content 1"),
        ("item1", "22/12/18 ", "content 2"),
        ("item2", "December", "content 3"),
        ("item3", "이십이년", "content 4")
    ]

    @IBOutlet var pageLabel: UILabel!
}

// MARK: - Lifecycle 🌎

extension MainViewController {

    override func viewDidLoad() {
        itemSize = CGSize(width: 256, height: 460)
        super.viewDidLoad()

        registerCell()
        fillCellIsOpenArray()
        addGesture(to: collectionView!)
        configureNavBar()
    }
}

// MARK: Helpers

extension MainViewController {

    fileprivate func registerCell() {

        let nib = UINib(nibName: String(describing: MainCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: MainCollectionViewCell.self))
    }

    fileprivate func fillCellIsOpenArray() {
        cellsIsOpen = Array(repeating: false, count: items.count)
    }

    fileprivate func getViewController() -> ExpandingTableViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let toViewController: MainTableViewController = storyboard.instantiateViewController(identifier: "MainTableViewController")
        return toViewController
    }

    fileprivate func configureNavBar() {
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    }
}

/// MARK: Gesture
extension MainViewController {

    fileprivate func addGesture(to view: UIView) {
        let upGesture = UISwipeGestureRecognizer(target: self, action:  #selector(MainViewController.swipeHandler(_:)))
        upGesture.direction = .up
        let downGesture = UISwipeGestureRecognizer(target: self, action: #selector(MainViewController.swipeHandler(_:)))
        downGesture.direction = .down
        view.addGestureRecognizer(upGesture)
        view.addGestureRecognizer(downGesture)
    }

    @objc func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        guard let cell = collectionView?.cellForItem(at: indexPath) as? MainCollectionViewCell else { return }
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            pushToViewController(getViewController())

            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }


        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened
    }
}

// MARK: UIScrollViewDelegate

extension MainViewController {

    func scrollViewDidScroll(_: UIScrollView) {
        var indexText = ""
        if items.count > 0 {
            indexText = "\(currentIndex + 1) / \(items.count)"
        }
        pageLabel.text = indexText
    }
}

// MARK: UICollectionViewDataSource

extension MainViewController {

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        guard let cell = cell as? MainCollectionViewCell else { return }

        let index = indexPath.row % items.count
        let info = items[index]
        cell.backgroundImageView?.image = UIImage(named: info.imageName)
       
        cell.customTitle.text = info.title
        // 라벨 글자 뒤 그림자 효과
        cell.customTitle.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.customTitle.layer.shadowOpacity = 0.8
        cell.customTitle.layer.shadowRadius = 2
        cell.customTitle.layer.shadowColor = CGColor.init(srgbRed: 0.83, green: 0.83, blue: 0.83, alpha: 1.0)
        
        cell.customContent.text = info.content
        cell.cellIsOpen(cellsIsOpen[index], animated: false)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MainCollectionViewCell
            , currentIndex == indexPath.row else { return }

        if cell.isOpened == false {
            cell.cellIsOpen(true)
        } else {
            pushToViewController(getViewController())

            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
    }
}

// MARK: UICollectionViewDataSource

extension MainViewController {

    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainCollectionViewCell.self), for: indexPath)
    }
}
