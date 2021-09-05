//
//  LocationLabel.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/30.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class LocationView: MediumWhiteLabel {
    private var locationLabel: MediumWhiteLabel!
    private var viewModel: LocationViewModel!
    private var cancellables: Set<AnyCancellable> = []

    required init(viewModel: LocationViewModel = LocationViewModel()) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        setupView()
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        locationLabel = MediumWhiteLabel()
        self.textAlignment = .center
        self.backgroundColor = UIColor(named: "Light Turqoise")
        self.text = viewModel.cityName
        self.addSubview(locationLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.$cityName
            .receive(on: DispatchQueue.main)
            .sink { self.text = $0 }
            .store(in: &cancellables)
    }
}


struct IntegratedLocationLabelView: UIViewRepresentable {

    @Binding var text: NSMutableAttributedString

    func makeUIView(context: Context) -> LocationView {
        let bodyLabel = LocationView()
        bodyLabel.textAlignment = .center
        bodyLabel.sizeToFit()
        return bodyLabel
    }

    func updateUIView(_ uiView: LocationView, context: Context) {
        uiView.attributedText = text
    }
}

struct LocationLabelView: View {

    @State var text = NSMutableAttributedString(string: "Johannesburg, ZA")

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .center) {
                Rectangle()
                    .frame(height: 45, alignment: .center)
                    .overlay(IntegratedLocationLabelView(text: $text))
            }
        }
    }
}

struct LocationLabelView_Previews: PreviewProvider {
    static var previews: some View {
        LocationLabelView()
            .preferredColorScheme(.light)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
