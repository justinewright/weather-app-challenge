//
//  TinyWhiteLabel.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/30.
//


import Foundation
import UIKit
import SwiftUI

class SmallWhiteLabel: Label {
    override func initialize() {
        super.initialize()
        self.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 45)
        self.font = .systemFont(ofSize: 12)
        self.textColor = .white
    }
}


struct IntegratedSmallWhiteLabelView: UIViewRepresentable {

    @Binding var text: NSMutableAttributedString

    func makeUIView(context: Context) -> SmallWhiteLabel {
        let bodyLabel = SmallWhiteLabel()
        bodyLabel.textAlignment = .center
        bodyLabel.sizeToFit()
        return bodyLabel
    }

    func updateUIView(_ uiView: SmallWhiteLabel, context: Context) {
        uiView.attributedText = text
    }
}

struct SmallWhiteLabelView: View {

    @State var text = NSMutableAttributedString(string: "Johannesburg, ZA")

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .center) {
                Rectangle()
                    .frame(height: 45, alignment: .center)
                    .overlay(IntegratedSmallWhiteLabelView(text: $text))
            }
        }
    }
}

struct SmallWhiteLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SmallWhiteLabelView()
            .preferredColorScheme(.light)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
