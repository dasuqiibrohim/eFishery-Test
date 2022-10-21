//
//  CustomSheetShowHide.swift
//  eFishery-Test
//
//  Created by ACI 2 on 22/10/22.
//

import SwiftUI

struct CustomSheetShowHide<Content: View>: View {
    @Binding var show: Bool
    var dismissAble = true
    @ViewBuilder var viewBuilder: Content
    
    // Gesture Porperties
    @State private var offset: CGFloat = 0
    @GestureState private var gestureOffset: CGFloat = 0
    @State private var counter = 0
    
    var body: some View {
        return GeometryReader { pr in
            let bottomSheet = pr.frame(in: .global).height+(GetHeightSafeArea() ?? 0)
            
            VStack {
                if show {
                    Spacer().onTapGesture {
                        if dismissAble {
                            withAnimation {
                                show = false
                                UIApplication.shared.endEditing()
                            }
                        }
                    }
                }
                viewBuilder
                    .background(
                        CustomRoundSpecificCornerShape(tl: 24, tr: 24, bl: 0, br: 0)
                            .fill(Color.N0)
                    )
                    .overlay(
                        CustomRoundSpecificCornerShape(tl: 24, tr: 24, bl: 0, br: 0)
                            .stroke(Color.N50, lineWidth: 0.5)
                    )
                    .offset(y: show ?
                                offset > 0 ? offset: 0
                                    : bottomSheet)
                    .gesture(
                        DragGesture()
                            .updating($gestureOffset, body: { value, out, _ in
                                if dismissAble {
                                    out = value.translation.height
                                    DispatchQueue.main.async {
                                        self.offset = gestureOffset
                                    }
                                }
                            })
                            .onEnded({value in
                                if dismissAble {
                                    withAnimation {
                                        if offset > 0 {
                                            show = false
                                            UIApplication.shared.endEditing()
                                        }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        offset = 0
                                    }
                                }
                            })
                    )
                    .ignoresSafeArea(.all, edges: .bottom)
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .background(
            withAnimation{
                show ? Color.black.opacity(0.5): nil
            }
        )
        .ignoresSafeArea(.all, edges: .vertical)
    }
}
