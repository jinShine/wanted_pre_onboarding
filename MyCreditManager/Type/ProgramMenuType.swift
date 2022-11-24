//
//  ProgramMenuType.swift
//  MyCreditManager
//
//  Created by buzz on 2022/11/25.
//

import Foundation

enum ProgramMenuType: String, CaseIterable {
  case addStudent = "1"
  case removeStudent = "2"
  case addGrade = "3"
  case removeGrade = "4"
  case showRating = "5"
  case termination = "X"

  var title: String {
    switch self {
    case .addStudent:
      return "학생추가"
    case .removeStudent:
      return "학생삭제"
    case .addGrade:
      return "성적추가(변경)"
    case .removeGrade:
      return "성적삭제"
    case .showRating:
      return "평점보기"
    case .termination:
      return "종료"
    }
  }
}
