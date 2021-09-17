//
//  Label+Extension.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//

import UIKit

extension UILabel {

    var SystemFont18: UILabel {
        self.font = .systemFont(ofSize: 18)
        return self
    }

    var SystemFont12: UILabel {
        self.font = .systemFont(ofSize: 12)
        return self
    }

    var White: UILabel {
        self.textColor = .white
        return self
    }

    var LightGray: UILabel {
        self.textColor = .lightGray
        return self
    }

}
