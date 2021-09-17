//
//  ViewController.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//

import UIKit

class ViewController: UIViewController {

    private lazy var secondViewController = MainRouter.createModule()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(secondViewController.view)
        self.addChild(secondViewController)
        secondViewController.didMove(toParent: self)
        self.view.backgroundColor = .black
    }

}
