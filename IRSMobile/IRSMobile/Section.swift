//
//  Section.swift
//  IRSMobile
//
//  Created by hungdn on 12/10/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import Foundation
struct Section {
    var genre: String!
    var movies: [String]!
    var expanded: Bool!
    
    init(genre: String, movies: [String], expanded: Bool) {
        self.genre = genre
        self.movies = movies
        self.expanded = expanded
    }
}
