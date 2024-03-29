//
//   IrregularVerbs.swift
//  MVC-lesson
//
//  Created by pravda on 24.07.2023.
//

import Foundation
import UIKit

class IrregularVerbs {
    // Singleton
    static var shared = IrregularVerbs()
    private init() {
        configureVerbs()
    }
    
    //MARK: - Properties
    var selectedVerbs: [Verb] = []
    
    private(set) var verbs: [Verb] = []
    
    //MARK: - Methods
    private func configureVerbs() {
        verbs = [
        Verb(infinitive: "blow", pastSimple: "blew", participle: "blown"),
        Verb(infinitive: "draw", pastSimple: "drew", participle: "drawn"),
        Verb(infinitive: "eat", pastSimple: "ate", participle: "eaten"),
        Verb(infinitive: "fall", pastSimple: "fell", participle: "fallen")
        ]
    }
}
