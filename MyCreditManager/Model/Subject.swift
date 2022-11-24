//
//  Subject.swift
//  MyCreditManager
//
//  Created by buzz on 2022/11/25.
//

import Foundation

struct Subject {
  var title: String
  var grade: String

  func transformGrade() -> Double {
    switch grade {
    case "A+":
        return 4.5
    case "A":
        return 4.0
    case "B+":
        return 3.5
    case "B":
        return 3.0
    case "C+":
        return 2.5
    case "C":
        return 2.0
    case "D+":
        return 1.5
    case "D":
        return 1.0
    default:
        return 0.0
    }
  }
}
