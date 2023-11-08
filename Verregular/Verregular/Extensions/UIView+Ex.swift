//
//  UIView+Ex.swift
//  Verregular
//
//  Created by pravda on 08.11.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
