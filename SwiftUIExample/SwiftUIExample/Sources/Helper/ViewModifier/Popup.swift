//
//  Popup.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/28/24.
//

import SwiftUI

enum PopupStyle {
    case none
    case blur
    case dimmed
}

extension View {
    func popup<Content: View>(
        isPresented: Binding<Bool>,
        size: CGSize? = nil,
        style: PopupStyle = .none,
        @ViewBuilder content: () -> Content
    ) -> some View {
        if isPresented.wrappedValue {
            
            let popup = Popup(size: size, style: style, message: content())
            let popupToggle = PopupToggle(isPresented: isPresented)
            let modifiedContent = self.modifier(popup).modifier(popupToggle)
            
            return AnyView(modifiedContent)
        } else {
            return AnyView(self)
        }
    }
    
    func popup<Item: Identifiable, Content: View>(
        item: Binding<Item?>,
        size: CGSize? = nil,
        style: PopupStyle = .none,
        @ViewBuilder content: (Item) -> Content
    ) -> some View {
        if let selectedItem = item.wrappedValue {
            let content = content(selectedItem)
            let popup = Popup(size: size, style: style, message: content)
            let popupItem = PopupItem(item: item)
            let modifiedContent = self.modifier(popup).modifier(popupItem)
            
            return AnyView(modifiedContent)
        } else {
            return AnyView(self)
        }
    }
    
    func popupOverContext<Item: Identifiable, Content: View>(
        item: Binding<Item?>,
        size: CGSize? = nil,
        style: PopupStyle = .none,
        ignoringEdges edges: Edge.Set = .all,
        @ViewBuilder content: (Item) -> Content
    ) -> some View {
        let isNonNil = item.wrappedValue != nil
        
        return ZStack {
            self.blur(radius: isNonNil && style == .blur ? 1.5 : 0)
            
            if isNonNil {
                Color.black
                    .luminanceToAlpha()
                    .popup(item: item, size: size, style: style, content: content)
                    .ignoresSafeArea(edges: edges)
            }
        }
    }
}

fileprivate struct Popup<Message: View>: ViewModifier {
    let size: CGSize?
    let style: PopupStyle
    let message: Message
    
    init(
        size: CGSize? = nil,
        style: PopupStyle = .none,
        message: Message
    ) {
        self.size = size
        self.style = style
        self.message = message
    }
    
    func body(content: Content) -> some View {
        content
            .blur(radius: style == .blur ? 1.5 : 0)
            .overlay(Rectangle()
                .fill(.black.opacity(style == .dimmed ? 0.4 : 0)))
            .overlay(popupContent)
    }
    
    private var popupContent: some View {
        GeometryReader {
            VStack { self.message }
                .frame(width: self.size?.width ?? $0.size.width * 0.6,
                       height: self.size?.height ?? $0.size.height * 0.25)
                .background(Color.primary.colorInvert())
                .clipShape(.rect(cornerRadius: 12))
                .shadow(color: .primaryShadow, radius: 15, x: 5, y: 5)
                .overlay(self.checkCircleMark, alignment: .top)
                .position(x: $0.size.width / 2, y: $0.size.height / 2)
        }
    }
    
    private var checkCircleMark: some View {
        Symbol("checkmark.circle.fill", color: .peach)
            .font(.system(size: 35).weight(.semibold))
            .background(Color.white.scaleEffect(0.6))
            .offset(x: 0, y: -30)
    }
}

fileprivate struct PopupToggle: ViewModifier {
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .disabled(isPresented)
            .onTapGesture { self.isPresented.toggle() }
    }
}

fileprivate struct PopupItem<Item: Identifiable>: ViewModifier {
    @Binding var item: Item?
    
    func body(content: Content) -> some View {
        content
            .disabled(item != nil)
            .onTapGesture { self.item = nil }
    }
}
