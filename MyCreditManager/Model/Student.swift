//
//  Student.swift
//  MyCreditManager
//
//  Created by buzz on 2022/11/25.
//

import Foundation

struct Student {
  var name: String = ""
  var subjects: [Subject] = []

  init(name: String) {
    self.name = name
    self.subjects = []
  }

  func printGrade() {
    let sum = subjects.reduce(0.0) { result, subject in
      print("\(subject.title): \(subject.grade)")
      return result + subject.transformGrade()
    }

    let avg = sum / Double(subjects.count)
    let avgFormat = String(format: "%.2f", avg)
    print("평점: \(avgFormat)")
  }
}
