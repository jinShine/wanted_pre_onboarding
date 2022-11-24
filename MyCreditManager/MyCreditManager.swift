//
//  MyCreditManager.swift
//  MyCreditManager
//
//  Created by buzz on 2022/11/25.
//

import Foundation

class MyCreditManager {

  private var datas: [Student] = []
  private var isRunning = true

  init() {}

  func start() {
    isRunning = true

    while isRunning {
      print("원하는 기능을 입력해주세요")
      print(ProgramMenuType.allCases.map { "\($0.rawValue): \($0.title)" }.joined(separator: ", "))

      let input = readLine()!

      switch menuType(for: input) {
      case .addStudent:
        addStudent()
      case .removeStudent:
        removeStudent()
      case .addGrade:
        addGrade()
      case .removeGrade:
        removeGrade()
      case .showRating:
        showRating()
      case .termination:
        stop()
      default:
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
        print("원하는 기능을 입력해주세요")
        print(ProgramMenuType.allCases.map { "\($0.rawValue): \($0.title)" }.joined(separator: ", "))
      }

      print(datas)
    }
  }

  func stop() {
    isRunning = false
  }

  private func addStudent() {
    print("추가할 학생의 이름을 입력해주세요.")

    let input = readLine()!

    if isValid(input) {
      if !containInDatas(for: input) {
        datas.append(Student(name: input))
        print("\(input) 학생을 추가했습니다.")
      } else {
        print("\(input)은/는 이미 존재하는 학생입니다. 추가하지 않습니다.")
      }
    } else {
      print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
  }

  private func removeStudent() {
    print("삭제할 학생의 이름을 입력해주세요.")

    let input = readLine()!

    if isValid(input) {
      if containInDatas(for: input) {
        if let index = indexInDatas(for: input) {
          datas.remove(at: index)
          print("\(input) 학생을 삭제하였습니다.")
        }
      } else {
        print("\(input) 학생을 찾지 못했습니다.")
      }
    } else {
      print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
  }

  private func addGrade() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")

    let input = readLine()!

    if isValid(input) {
      let requiredInputCount = 3
      let inputDatas = input.components(separatedBy: " ")

      if inputDatas.count == requiredInputCount {
        let name = inputDatas[0]
        let subjectTitle = inputDatas[1]
        let subjectGrade = inputDatas[2]

        if let studentIndex = indexInDatas(for: name) {
          if let subjectIndex = datas[studentIndex].subjects.firstIndex(where: { $0.title == subjectTitle }) {
            datas[studentIndex].subjects[subjectIndex].grade = subjectGrade
          } else {
            datas[studentIndex].subjects.append(Subject(title: subjectTitle, grade: subjectGrade))
          }
          print("\(name) 학생의 \(subjectTitle) 과목이 \(subjectGrade)로 추가(변경)되었습니다.")
        } else {
          print("\(name) 학생을 찾지 못했습니다.")
        }
      } else {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
      }
    } else {
      print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
  }

  private func removeGrade() {
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어스기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift")

    let input = readLine()!

    if isValid(input) {
      let requiredInputCount = 2
      let inputDatas = input.components(separatedBy: " ")

      if inputDatas.count == requiredInputCount {
        let name = inputDatas[0]
        let subjectTitle = inputDatas[1]

        if let studentIndex = indexInDatas(for: name) {
          if let subjectIndex = datas[studentIndex].subjects.firstIndex(where: { $0.title == subjectTitle }) {
            datas[studentIndex].subjects.remove(at: subjectIndex)
            print("\(name) 학생의 \(subjectTitle) 과목의 성적이 삭제되었습니다.")
          } else {
            print("\(name)의 \(subjectTitle) 과목을 찾지 못했습니다.")
          }
        } else {
          print("\(name) 학생을 찾지 못했습니다.")
        }
      } else {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
      }
    } else {
      print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
  }

  private func showRating() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요.")

    let input = readLine()!

    if isValid(input) {
      if let studentIndex = indexInDatas(for: input) {
        datas[studentIndex].printGrade()
      } else {
        print("\(input) 학생을 찾지 못했습니다.")
      }
    } else {
      print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
  }
}

extension MyCreditManager {
  
  private func menuType(for input: String) -> ProgramMenuType? {
    ProgramMenuType(rawValue: input.uppercased())
  }

  private func isValid(_ input: String) -> Bool {
    return !input.trimmingCharacters(in: .whitespaces).isEmpty && menuType(for: input) == nil
  }

  private func containInDatas(for name: String) -> Bool {
    datas.contains(where: { $0.name == name })
  }

  private func indexInDatas(for name: String) -> Int? {
    datas.firstIndex(where: { $0.name == name })
  }
}
