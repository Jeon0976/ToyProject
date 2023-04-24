//
//  SelectRegionView.swift
//  FindCoronaCenter
//
//  Created by 전성훈 on 2022/11/25.
//

import SwiftUI

struct SelectRegionView: View {
    // func bind(viewModel)
    @ObservedObject var viewModel = SelectRegionViewModel()
    
    private var items: [GridItem] {
        Array(repeating: .init(.flexible(minimum:80)), count: 2)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: items, spacing: 20) {
                    ForEach(Center.Sido.allCases, id: \.id) { sido in
                        let centers = viewModel.centers[sido] ?? []
                        NavigationLink(
                            destination: CenterList(centers: centers)) {
                                SelectRegionItem(region: sido, count: centers.count)
                            }
                    }
                }
                .padding()
                .navigationTitle("코로나19 예방접종 센터")
            }
        }
    }
}

struct SelectRegionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SelectRegionViewModel()
        SelectRegionView(viewModel: viewModel)
    }
}
