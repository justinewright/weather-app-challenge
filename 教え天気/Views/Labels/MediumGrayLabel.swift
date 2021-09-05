//
//  MediumGrayLabel.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/30.
//

import Foundation
import UIKit
import SwiftUI

class MediumGrayLabel: Label {
    override func initialize() {
        super.initialize()
        self.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 45)
        self.font = .systemFont(ofSize: 18)
        self.textColor = .white
    }
}


struct IntegratedMediumGrayLabelView: UIViewRepresentable {

    @Binding var text: NSMutableAttributedString

    func makeUIView(context: Context) -> MediumGrayLabel {
        let bodyLabel = MediumGrayLabel()
        bodyLabel.textAlignment = .center
        bodyLabel.sizeToFit()
        return bodyLabel
    }

    func updateUIView(_ uiView: MediumGrayLabel, context: Context) {
        uiView.attributedText = text
    }
}

struct MediumGrayLabelView: View {

    @State var text = NSMutableAttributedString(string: "Johannesburg, ZA")

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .center) {
                Rectangle()
                    .frame(height: 45, alignment: .center)
                    .overlay(IntegratedMediumGrayLabelView(text: $text))
            }
        }
    }
}

struct MediumGrayLabelViewView_Previews: PreviewProvider {
    static var previews: some View {
        MediumGrayLabelView()
            .preferredColorScheme(.light)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
