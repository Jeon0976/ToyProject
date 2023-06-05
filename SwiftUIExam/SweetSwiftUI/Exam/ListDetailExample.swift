//
//  ListDetailExample.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/05.
//

import SwiftUI

struct ListDetailExample: View {

    
    var body: some View {
        let section = ["1","2","3"]
        let data = [[Test(name: "Test1"), Test(name: "Test2"), Test(name: "Test")],
                    [Test(name: "Test"), Test(name: "Tes34t"), Test(name: "Test"), Test(name: "Test"), Test(name: "Test")],
                    [Test(name: "Test"), Test(name: "Tes535t"), Test(name: "Test")],
        ]
        
        List {
            ForEach(section.indices, id: \.self) { index in
                Section {
                    ForEach(data[index]) {
                        Text($0.name)
                    }
                } header: {
                    Text(section[index])
                        .font(.title)
                } footer: {
                    HStack {
                        Spacer()
                        Text("\(data[index].count)건")
                    }
                }

            }
        }
        .listStyle(InsetGroupedListStyle())
//        VStack {
//            List {
//                Text("번호")
//                ForEach(0..<10) {
//                    Text("\($0)")
//                }
//            }
//            Spacer()
//            List([1,2,3,4,5], id: \.self) {
//                Text("\($0)")
//            }
//            Spacer()
//            List([Test(name: "Test"), Test(name: "Test2")]) {
//                Text("\($0.name)")
//            }
//        }
    }
}

struct ListDetailExample_Previews: PreviewProvider {
    static var previews: some View {
        ListDetailExample()
    }
}


struct Test: Identifiable, Hashable, Equatable {
    let id = UUID()
    let name: String
}
