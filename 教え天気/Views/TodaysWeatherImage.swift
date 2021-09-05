//
//  TodaysWeatherImage.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/27.
//

import Foundation

import UIKit
import SwiftUI

class TodaysWeatherImage: UIView {
    private var weatherSymbolView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.frame = CGRect(x: 0, y: 0, width: 150, height: 150)

        let imageInset: CGFloat = 5
        let weatherSymbolView = UIImageView(frame: self.frame)
        weatherSymbolView.contentMode = .scaleAspectFill
        let weatherSymbolImage = UIImage(systemName: "sun.max")?.withTintColor(.white, renderingMode: .alwaysOriginal)

        weatherSymbolView.contentScaleFactor = 5
        weatherSymbolView.image = weatherSymbolImage?.resizableImage(withCapInsets: UIEdgeInsets(top: imageInset, left: imageInset, bottom: imageInset, right: imageInset), resizingMode: .tile)
        weatherSymbolView.contentMode = .center

        weatherSymbolView.translatesAutoresizingMaskIntoConstraints =  false

        self.addSubview(weatherSymbolView)

        weatherSymbolView.makeRounded()

        weatherSymbolView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        weatherSymbolView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        weatherSymbolView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        weatherSymbolView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        weatherSymbolView.image = weatherSymbolImage?.resizeImage(targetSize: CGSize(width: 80, height: 80))

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 10
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 75
        self.layer.shadowColor = UIColor.systemPink.cgColor
        self.layer.shadowRadius = 20
        self.layer.backgroundColor = UIColor.systemPink.cgColor
        self.layer.shadowOpacity =  1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
      }
}

struct IntegratedTodaysWeatherImage: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<IntegratedTodaysWeatherImage>) -> TodaysWeatherImage {
        return TodaysWeatherImage()
    }

    func updateUIView(_ uiView: TodaysWeatherImage, context: UIViewRepresentableContext<IntegratedTodaysWeatherImage>) {}

}

struct TodaysWeatherImageView: View {

    var body: some View {
        IntegratedTodaysWeatherImage()
    }
}

struct TodaysWeatherImageView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysWeatherImageView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
