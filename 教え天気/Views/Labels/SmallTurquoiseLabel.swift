//
//  SmallTurquoiseLabel.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/30.
//

import Foundation
import UIKit
import SwiftUI

class SmallTurqoiseLabel: Label {
    override func initialize() {
        super.initialize()
        self.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 45)
        self.font = .systemFont(ofSize: 12)
        self.textColor = .lightGray
    }
}

struct IntegratedSmallTurqoiseLabelView: UIViewRepresentable {

    @Binding var text: NSMutableAttributedString

    func makeUIView(context: Context) -> SmallTurqoiseLabel {
        let bodyLabel = SmallTurqoiseLabel()
        bodyLabel.textAlignment = .center
        bodyLabel.sizeToFit()
        return bodyLabel
    }

    func updateUIView(_ uiView: SmallTurqoiseLabel, context: Context) {
        uiView.attributedText = text
    }
}

struct SmallTurqoiseLabelView: View {

    @State var text = NSMutableAttributedString(string: "Johannesburg, ZA")

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .center) {
                Rectangle()
                    .frame(height: 45, alignment: .center)
                    .overlay(IntegratedSmallTurqoiseLabelView(text: $text))
            }
        }
    }
}

struct SmallTurqoiseLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SmallWhiteLabelView()
            .preferredColorScheme(.light)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
