//
//  Verb.swift
//  MVC-lesson
//
//  Created by pravda on 24.07.2023.
//

import UIKit


struct Verb {
    let infinitive: String
    let pastSimple: String
    let participle: String
    var translation: String {
        NSLocalizedString(self.infinitive, comment: "")
    }
}
