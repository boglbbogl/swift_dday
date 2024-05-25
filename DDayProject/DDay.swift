//
//  DDay.swift
//  DDayProject
//
//  Created by Tyger Hwang on 5/26/24.
//

import Foundation

struct DDay : Identifiable {
    var id = UUID()
    var title : String?
    var date : Date = Date()
}
