//
//  MediumWhiteLabel.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/30.
//

import Foundation

import Foundation
import UIKit
import SwiftUI

class MediumWhiteLabel: Label {
    override func initialize() {
        super.initialize()
        self.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 45)
        self.font = .systemFont(ofSize: 18)
        self.textColor = .white
    }
}

struct IntegratedMediumWhiteLabelView: UIViewRepresentable {

    @Binding var text: NSMutableAttributedString

    func makeUIView(context: Context) -> MediumWhiteLabel {
        let bodyLabel = MediumWhiteLabel()
        bodyLabel.textAlignment = .center
        bodyLabel.sizeToFit()
        return bodyLabel
    }

    func updateUIView(_ uiView: MediumWhiteLabel, context: Context) {
        uiView.attributedText = text
    }
}

struct MediumWhiteLabelView: View {

    @State var text = NSMutableAttributedString(string: "Johannesburg, ZA")

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .center) {
                Rectangle()
                    .frame(height: 45, alignment: .center)
                    .overlay(IntegratedMediumWhiteLabelView(text: $text))
            }
        }
    }
}

struct MediumWhiteLabelView_Previews: PreviewProvider {
    static var previews: some View {
        MediumWhiteLabelView()
            .preferredColorScheme(.light)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
