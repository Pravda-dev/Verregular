//
//  UIStackView+Ex.swift
//  Verregular
//
//  Created by pravda on 08.11.2023.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
            
        }
    }
}
