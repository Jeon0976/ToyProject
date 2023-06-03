//
//  ImageExam.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/05/30.
//

import SwiftUI

struct ImageExam: View {
    var body: some View {
        VStack(spacing: 10){
            Image("167")
                .resizable(capInsets: .init(top: 0, leading: 15, bottom: 0, trailing: 0))
                .frame(width: 150,height: 50)
            Image("167")
                .clipShape(Circle())
            Image("167")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fill)
                .frame(width: 100,height: 100)
                .cornerRadius(10.0)
                .padding(.all,16)
            Image("167")
                .renderingMode(.template)
                .foregroundColor(.blue)
                .opacity(0.5)
                .clipShape(Ellipse().path(in: CGRect(x: 10, y: 10, width: 80, height: 100)))
            HStack(spacing: 20) {
                Image(systemName: "star.circle")
                    .font(.system(size: 50))
                Image(systemName: "star.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(.green)
                    .font(.body)
            }
        }
    }
}

struct ImageExam_Previews: PreviewProvider {
    static var previews: some View {
        ImageExam()
    }
}
