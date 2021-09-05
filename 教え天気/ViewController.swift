//
//  ViewController.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/27.
//

import UIKit

class ViewController: UIViewController {
    private var mainView: MainView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = MainView()
        view = mainView
        view.topColouredBlack()
        // Do any additional setup after loading the view.
    }


}

