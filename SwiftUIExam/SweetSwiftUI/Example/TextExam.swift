//
//  TextExam.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/05/30.
//

import SwiftUI

struct TextExam: View {
    @State private var isInvered = false
    
    var body: some View {
        VStack(spacing: 18) {
            Text("폰트와 굵기 설정")
                .font(.title)
                .fontWeight(.black)
            Text("글자색은 foreground, 배경은 background")
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(8)
                .padding()
                .background(Color.black)
                .cornerRadius(8)
            Text("커스텀 폰트, 볼드체, 이탤릭체, 밑줄, 취소선")
                .font(.custom("Menlo", size: 16))
                .bold()
                .italic()
                .underline()
                .strikethrough()
            Text("라인 수 제한과\n텍스트 정렬 기능\n세번째 라인")
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            // 2개 이상의 텍스트를 하나로 묶어서 동시에 적용
            (Text("자간과 기준선").kerning(8) + Text(" 조정 쉽게 가능").baselineOffset(8))
                .font(.system(size: 16))
        }
    }
}

struct TextExamView_Previews: PreviewProvider {
    static var previews: some View {
        TextExam()
    }
}
