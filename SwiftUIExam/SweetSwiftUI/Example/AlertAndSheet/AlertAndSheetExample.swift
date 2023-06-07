//
//  AlertExample.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/07.
//

import SwiftUI

struct AlertAndSheetExample: View {
    @State private var showingAlert = false
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            Button(action: { self.showingAlert.toggle()
                print(showingAlert)
            }) {
                Text("Alert")
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("제목"),
                      message: Text("내용"),
                      primaryButton: .default(Text("확인"), action: { print("Check") }),
                      secondaryButton: .cancel(Text("취소"))
                )
            }
            Button(action: { self.showingSheet.toggle() }) {
                Text("Present")
            }
            .sheet(isPresented: $showingSheet,
                   onDismiss: { print("Dismissed") } ,
                   content: { PresentView() })
        }
    }
}

struct AlertAndSheetExample_Previews: PreviewProvider {
    static var previews: some View {
        AlertAndSheetExample()
    }
}
