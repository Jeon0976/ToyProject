//
//  NavigationViewExample.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/05.
//

import SwiftUI

struct NavigationViewExample: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Mint", value: Color.mint)
                NavigationLink("Pink", value: Color.pink)
                NavigationLink("Teal", value: Color.teal)
                Circle()
                    .frame(width: 80, height: 80)
                    .padding()
                Image("167")
                    .padding()
            }
            .navigationDestination(for: Color.self) { color in
                ColorDetail(color: color)
            }
            .navigationTitle("Colors")
            .navigationBarTitleDisplayMode(.large)
            .toolbar() {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { print("Leading")}) {
                        Image(systemName: "bell")
                            .imageScale(.large)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { print("Trailig")}) {
                        Image(systemName: "gear")
                            .imageScale(.large)
                    }
                }
            }
//            .toolbar(.hidden, for: .navigationBar)
        }
    }
}


struct NavigationViewExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewExample()
    }
}
