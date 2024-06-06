//
//  MyPage.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/30/24.
//

import SwiftUI

struct MyPage: View {
    @EnvironmentObject private var store: Store
    
    @State private var pickedImage: Image = Image(systemName: "person.crop.circle")
    @State private var nickname: String = ""
    @State private var isPickerPresented: Bool = false
    
    private let pickerDataSource: [CGFloat] = [130, 150, 200]
    
    var body: some View {
        NavigationStack {
            Form {
                userInfo
                orderInfoSection
                appSettingSection
            }
            .navigationTitle("마이페이지")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isPickerPresented, content: {
                ImagePickerView(pickedImage: $pickedImage)
            })
        }
    }
}

private extension MyPage {
    var userInfo: some View {
        VStack {
            profileImage
            nicknameTextField
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .background(Color.background)
        .clipShape(.rect(cornerRadius: 8))
    }
    
    var profileImage: some View {
        pickedImage
            .resizable().scaledToFill()
            .clipShape(Circle())
            .frame(width: 100, height: 100)
            .overlay(pickerButton.offset(x: 0, y: 0), alignment: .bottomTrailing)
    }
    
    var pickerButton: some View {
        Button(action: { self.isPickerPresented = true }, label: {
            Circle()
                .fill(Color.white)
                .frame(width: 32, height: 32)
                .shadow(color: .primaryShadow, radius: 2, x: 2, y: 2)
                .overlay(Image("pencil").renderingMode(.template))
                .foregroundStyle(.black)
        })
    }
    
    var nicknameTextField: some View {
        TextField("닉네임", text: $nickname)
            .font(.system(size: 25, weight: .medium))
            .textContentType(.nickname)
            .multilineTextAlignment(.center)
            .textInputAutocapitalization(.never)
    }
    
    var orderInfoSection: some View {
        Section {
            NavigationLink(destination: OrderListView()) {
                Text("주문 목록")
            }
            .frame(height: 44)
        } header: {
            Text("주문 정보").fontWeight(.medium)
        }
    }
    
    var appSettingSection: some View {
        Section {
            Toggle("즐겨찾는 상품 표시", isOn: $store.appSetting.showFavoriteList)
                .frame(height: 44)
            productHeightPicker
        } header: {
            Text("앱 설정").fontWeight(.medium)
        }
    }
    
    var productHeightPicker: some View {
        
        VStack(alignment: .leading) {
            Text("상품 이미지 높이 조절")
            
            Picker("", selection: $store.appSetting.productRowHeight) {
                ForEach(pickerDataSource, id: \.self) {
                    Text(String(format: "%.0f", $0)).tag($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .frame(height: 72)
    }
}

#Preview {
    MyPage().environmentObject(Store())
}
