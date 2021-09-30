//
//  ViewController.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/27.
//

import UIKit
import SwiftUI

protocol BaseViewProtocol {
    func configure(withContent content: Any)
}

class BaseView: UIView {

    // MARK: - Parameters
    private var titleLabel: UILabel!
    private var contentView: UIView!
    private var padding: CGFloat = 10

    // MARK: - Initialization
    init(titleText: String, content: UIView) {
        super.init(frame: .zero)
        addTitleLabel(titleText)
        addContentView(content)
        style()
    }

    private func addContentView(_ content: UIView) {
        contentView = content
        addSubview(contentView)
        addContentViewConstraints()
    }

    private func addContentViewConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: padding),
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }

    private func addTitleLabel(_ title: String) {
        titleLabel = UILabel().SystemFont14.LightGray
        titleLabel.text =  title
        backgroundColor = UIColor(named: "dark gray")
        titleLabel.backgroundColor = .black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        addTitleLabelConstraints()
    }

    private func addTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.widthAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func style() {
        backgroundColor = UIColor(named: "dark gray")
        layer.cornerRadius = 10
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

final class CurrentWeatherView: UIView {
    // MARK: - Properties
    private var characterMask: UIImageView!
    private var characterBackgroundImageView: UIImageView!
    private var descriptionLabel: UILabel!
    private var currentTemperatureLabel: UILabel!
    private var highTemperatureLabel: UILabel!
    private var lowTemperatureLabel: UILabel!
    private var lineView: UIView!

    init() {
        super.init(frame: .zero)

        setupView()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views

    private func setupView() {
        setupImageView()
        setupDescriptionLabel()
        setupCurrentTemperatureLabel()
        setupHighTemperatureLabel()
        setupLowTemperatureLabel()
        setupLine()
        setupConstraints()
    }

    private func setupImageView() {
        let image = UIImage(named: "rain")!
        let mask = UIImage(named: "character")!
        let size = image.size

        let renderer = UIGraphicsImageRenderer(size: size)
        let newImage = renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: 1)
            mask.draw(in: CGRect(origin: .zero, size: size), blendMode: .lighten, alpha: 0.2)
            mask.draw(in: CGRect(origin: .zero, size: size), blendMode: .destinationIn, alpha: 1)
        }
        characterMask = UIImageView(image: newImage)
        characterMask.contentMode = .scaleAspectFit
        addSubview(characterMask)
    }

    private func setupDescriptionLabel() {
        descriptionLabel = UILabel().LightGray.SystemFont10
        descriptionLabel.text = "Description Text..."
        descriptionLabel.textAlignment = .right
        addSubview(descriptionLabel)
    }

    private func setupCurrentTemperatureLabel() {
        currentTemperatureLabel = UILabel().SystemFont24.t1
        currentTemperatureLabel.text = "25°C"
        currentTemperatureLabel.textAlignment = .right
        addSubview(currentTemperatureLabel)
    }

    private func setupHighTemperatureLabel() {
        highTemperatureLabel = UILabel().LightGray.SystemFont12
        highTemperatureLabel.text = "H: 30°C"
        highTemperatureLabel.textAlignment = .left
        addSubview(highTemperatureLabel)
    }

    private func setupLowTemperatureLabel() {
        lowTemperatureLabel = UILabel().LightGray.SystemFont12
        lowTemperatureLabel.text = "L: 5°C"
        lowTemperatureLabel.textAlignment = .left
        addSubview(lowTemperatureLabel)
    }

    private func setupLine() {
        lineView = UIView(frame: CGRect(x: 0, y: frame.height - 3, width: frame.width * 0.6, height: 3.0))
        lineView.backgroundColor = .white
        addSubview(lineView)
    }

    // MARK: - Constraints

    private func setupConstraints() {
        setupImageViewConstraints()
        setupDescriptionLabelConstraints()
        setupCurrentTemperatureLabelConstraints()
        setupHighTemperatureLabelConstraints()
        setupLowTemperatureLabelConstraints()
        setupLineConstraints()
    }

    private func setupImageViewConstraints() {

        characterMask.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            characterMask.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            characterMask.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            characterMask.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupDescriptionLabelConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.trailingAnchor.constraint(equalTo: currentTemperatureLabel.leadingAnchor, constant: -5),
            descriptionLabel.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: -5),
            descriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: lineView.leadingAnchor)
        ])
    }

    private func setupCurrentTemperatureLabelConstraints() {
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatureLabel.sizeToFit()
        NSLayoutConstraint.activate([
            currentTemperatureLabel.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
            currentTemperatureLabel.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: 0)

        ])
    }

    private func setupHighTemperatureLabelConstraints() {
        highTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        highTemperatureLabel.sizeToFit()
        NSLayoutConstraint.activate([
            highTemperatureLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            highTemperatureLabel.centerXAnchor.constraint(equalTo: currentTemperatureLabel.centerXAnchor, constant: 0)

        ])
    }

    private func setupLowTemperatureLabelConstraints() {
        lowTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        lowTemperatureLabel.sizeToFit()
        NSLayoutConstraint.activate([
            lowTemperatureLabel.topAnchor.constraint(equalTo: highTemperatureLabel.bottomAnchor),
            lowTemperatureLabel.trailingAnchor.constraint(equalTo: highTemperatureLabel.trailingAnchor, constant: 0)

        ])
    }

    private func setupLineConstraints() {
        lineView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lineView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

    }
}

final class HourlyWeatherView: UIView {
    lazy var collectionView = ReusableCollectionView(cellWidth: HourlyCell.flexibleWidth, cellHeight: HourlyCell.flexibleHeight)
    let dataSource = HourlyForecastDataSource()

    init() {
        super.init(frame: .zero)
        setupView()

        DispatchQueue.main.async {
//            self.collectionView.register(cellType: HourlyCell.self)
            self.collectionView.register(cellType: HourlyCell.self)
            self.collectionView.collectionView.dataSource = self.dataSource
            self.dataSource.config(data: defaultHourlyData.map { HourlyWeather(hourlyWeather: $0, timeZone: defaultTimeZone)
            })
        }
        collectionView.refresh()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle Methods

    func setupView() {
        addSubview(collectionView)
        setupConstraints()
    }

    func setupConstraints() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


final class DetailsWeatherView: UIView {
    lazy var collectionView = ReusableCollectionView(cellWidth: DetailsCell.flexibleWidth, cellHeight: DetailsCell.flexibleWidth)
    let dataSource = WeatherDetailsDataSource()

    init() {
        super.init(frame: .zero)
        setupView()

        DispatchQueue.main.async {
            self.collectionView.register(cellType: DetailsCell.self)
            self.collectionView.collectionView.dataSource = self.dataSource
            self.dataSource.config(data: DailyWeather(dailyWeather: defaultDailyData.first!))
        }
        collectionView.refresh()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle Methods

    func setupView() {
        addSubview(collectionView)
        setupConstraints()
    }

    func setupConstraints() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

final class FiveDayForecastWeatherView: UIView {
    private lazy var collectionView = ForecastCollectionView()
    init() {
        super.init(frame: .zero)

        setupView()
        collectionView.refresh(data: defaultDailyData.map(DailyWeather.init))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(collectionView)
        setupConstraints()

    }

    private func setupConstraints() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

class ViewController: UIViewController {
    private var vStack: UIStackView!

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        let redView = CurrentWeatherView()
        redView.backgroundColor = .clear
        let blueView = HourlyWeatherView()

        let greenView = FiveDayForecastWeatherView()

        let pinkView = DetailsWeatherView()
 
        
        let current = BaseView(titleText: "現\r\n在", content: redView)
        current.translatesAutoresizingMaskIntoConstraints = false
        let hourly = BaseView(titleText: "一\r\n時\r\n間\r\nご\r\nと", content: blueView)
        hourly.translatesAutoresizingMaskIntoConstraints = false
        let forecast = BaseView(titleText: "五\r\n日\r\n間", content: greenView)
        forecast.translatesAutoresizingMaskIntoConstraints = false
        let details = BaseView(titleText: "詳\r\n細", content: pinkView)

        details.translatesAutoresizingMaskIntoConstraints = false

        initVerticalStackView(views: [current, hourly, forecast, details])

        setupStackConstraints()
        current.makeLargeView(anchorTo: view)
        hourly.makeMediumView(anchorTo: view)
        forecast.makeMediumView(anchorTo: view)
        details.makeLargeView(anchorTo: view)
    }

    private func initVerticalStackView(views: [UIView]) {
        vStack = UIStackView(arrangedSubviews: views)
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.spacing = 10
        vStack.alignment = .center
        vStack.isLayoutMarginsRelativeArrangement = true
        vStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom:0, trailing: 0)
        vStack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.addSubview(vStack)
    }

    private func setupStackConstraints() {
        let bottomAnchorr = vStack.arrangedSubviews.isEmpty ? view.topAnchor : vStack.arrangedSubviews.last?.bottomAnchor
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        vStack.bottomAnchor.constraint(equalTo: bottomAnchorr!).isActive = true
        vStack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }

}

struct IntegratedVC: UIViewControllerRepresentable {

    func makeUIViewController(context: UIViewControllerRepresentableContext<IntegratedVC>) -> ViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: ViewController, context: UIViewControllerRepresentableContext<IntegratedVC>) {}

}

struct DashView: View {

    var body: some View {
        ZStack {

            VStack(alignment: .center, spacing: 0){
                HStack(alignment: .bottom) {
                    Text("Johannesburg, SA")
                        .font(.subheadline)
                }
                IntegratedVC()
            }
        }
    }
}

struct DashView_Previews: PreviewProvider {
    static var previews: some View {
        DashView()
            .preferredColorScheme(.dark)
    }
}
