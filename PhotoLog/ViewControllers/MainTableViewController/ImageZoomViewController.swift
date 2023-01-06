//
//  ImageZoomViewController.swift
//  PhotoLog
//
//  Created by Lio on 2023/01/06.
//

import UIKit

class ImageZoomViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        imageView.image = UIImage(named: "item1")
        scrollView.delegate = self
        scrollView.zoomScale = 1.0
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension ImageZoomViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.zoomScale <= 1.0 {
            scrollView.zoomScale = 1.0
        }

        if scrollView.zoomScale >= 2.0 {
            scrollView.zoomScale = 2.0
        }
    }
}
