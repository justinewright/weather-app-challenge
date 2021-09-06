//
//  ViewController.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/27.
//

import UIKit

class WeatherViewController: UIViewController {
    private var mainView: MainWeatherView!
    private var viewModel: MainViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        view.topColoured()
        view.clipsToBounds = true
    }

    init(viewModel: MainViewModel = MainViewModel()) {
        self.viewModel = viewModel
        self.mainView =  MainWeatherView(viewModel: viewModel)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

}
