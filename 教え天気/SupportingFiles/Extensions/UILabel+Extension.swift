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

    var SystemFont10: UILabel {
        self.font = .systemFont(ofSize: 10)
        return self
    }

    var SystemFont8: UILabel {
        self.font = .systemFont(ofSize: 8)
        return self
    }
    var SystemFont14: UILabel {
        self.font = .systemFont(ofSize: 14)
        return self
    }

    var SystemFont24: UILabel {
        self.font = .systemFont(ofSize: 24)
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

    var t0: UILabel {
        self.textColor = UIColor(named: "Light Turqoise")
        return self
    }

    var t1: UILabel {
        self.textColor = UIColor(named: "T1")
        return self
    }

}
