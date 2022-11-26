//
//  AddScheduleView.swift
//  Calendar1
//
//  Created by woody on 2022/11/26.
//

import SwiftUI

struct AddScheduleView: View {
  @State private var startDate: Date = Date()
  @State private var endDate: Date = Date()
  @State private var title: String = ""
  @State private var content: String = ""
  
  @State private var alertMessage: String = "" {
    didSet {
      self.isAlertPresented = !self.alertMessage.isEmpty
    }
  }
  @State private var isAlertPresented: Bool = false

  @Environment(\.dismiss) private var dismiss

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
      .navigationBarTitle("새로운 이벤트", displayMode: .inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("취소") {
            self.dismiss()
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("추가") {
            self.addButtonTapped()
          }
          .disabled(self.title.isEmpty)
        }
      }
    }.alert(self.alertMessage, isPresented: self.$isAlertPresented) { }
  }
  
  private func addButtonTapped() {
    guard self.startDate <= self.endDate else {
      self.alertMessage = "올바르게 날짜 설정을 해주세요"
      return
    }
    
    Task {
      do {
        let response: RegisterScheduleResponse = try await Promise.shared.request(
          .registerSchedule(title: self.title, content: self.content, startDate: self.startDate, endDate: self.endDate)
        )
        
        if response.status == "OK" {
          self.dismiss()
        }
      } catch let error {
        print(error)
      }
    }
  }
}

struct AddScheduleView_Previews: PreviewProvider {
  static var previews: some View {
    AddScheduleView()
  }
}
