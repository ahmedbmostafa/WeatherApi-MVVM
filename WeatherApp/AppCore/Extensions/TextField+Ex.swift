//
//  TextField+Ex.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 10/11/2022.
//

import UIKit

class RoundTxtF: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
    override func awakeFromNib() {
        setupView()
    }

    func setupView() {
        self.layer.cornerRadius = 15
        self.layer.borderColor = #colorLiteral(red: 0.2666666667, green: 0.3058823529, blue: 0.4470588235, alpha: 1)
        self.layer.borderWidth = 1
    }

        override open func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        override open func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
}
