//
//  ViewController.swift
//  TimeCapsule
//
//  Created by Lio on 2022/11/01.
//

import UIKit
import expanding_collection


class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func showNext(_ sender: UIButton) {
         guard let vc = storyboard?.instantiateViewController(withIdentifier: "DemoViewController") else {
            return
        }
        present(vc, animated: true)
    }
}

