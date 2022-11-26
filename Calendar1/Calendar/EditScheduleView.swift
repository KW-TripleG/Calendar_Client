//
//  EditScheduleView.swift
//  Calendar1
//
//  Created by woody on 2022/11/26.
//

import SwiftUI

struct EditScheduleView: View {
  @State private var startDate: Date
  @State private var endDate: Date
  @State private var title: String
  @State private var content: String
  
  @State private var alertMessage: String = "" {
    didSet {
      self.isAlertPresented = !self.alertMessage.isEmpty
    }
  }
  @State private var isAlertPresented: Bool = false
  private let id: Int

  @Environment(\.dismiss) private var dismiss
  @EnvironmentObject var global: Global
  
  init(schedule: Schedule) {
    self.id = schedule.id
    self._startDate = State(initialValue: schedule.startDate)
    self._endDate = State(initialValue: schedule.endDate)
    self._title = State(initialValue: schedule.title)
    self._content = State(initialValue: schedule.content)
  }

  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("제목", text: $title)
          TextField("내용", text: $content)
        }
        
        Section {
          DatePicker("시작", selection: $startDate)
          DatePicker("종료", selection: $endDate)
        }
      }
      .navigationBarTitle("이벤트 수정", displayMode: .inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("취소") {
            self.dismiss()
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("수정") {
            self.editButtonTapped()
          }
          .disabled(self.title.isEmpty)
        }
      }
    }.alert(self.alertMessage, isPresented: self.$isAlertPresented) { }
  }
  
  private func editButtonTapped() {
    guard self.startDate <= self.endDate else {
      self.alertMessage = "올바르게 날짜 설정을 해주세요"
      return
    }
    
    Task {
      do {
        let response: RegisterScheduleResponse = try await Promise.shared.request(
          .updateSchedule(id: self.id, title: self.title, content: self.content, startDate: self.startDate, endDate: self.endDate)
        )
        
        if response.status == "OK" {
          self.global.fetchSchedules()
          self.dismiss()
        }
      } catch let error {
        print(error)
      }
    }
  }
}
