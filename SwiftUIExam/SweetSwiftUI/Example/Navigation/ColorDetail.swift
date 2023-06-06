//
//  ColorDetail.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/05.
//

import SwiftUI

struct ColorDetail: View {
    var color: Color
    
    var body: some View {
        Text("\(self.color.description)")
//            .navigationBarBackButtonHidden(true)
            
    }
}

struct ColorDetail_Previews: PreviewProvider {
    static var previews: some View {
        ColorDetail(color: .black)
    }
}
