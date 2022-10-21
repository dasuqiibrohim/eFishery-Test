//
//  ContentView.swift
//  eFishery-Test
//
//  Created by ACI 2 on 21/10/22.
//

import SwiftUI

struct ContentView: View {
    private let itemColumns = [GridItem(.flexible()),
                                GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 16) {
                HStack {
                    Text("Lits perikanan di Indonesia")
                        .font(.custom(Cnst.txt.fInterBold, size: 16))
                        .foregroundColor(.N100)
                    Spacer()
                    
                    Image(systemName: "plus.square")
                        .font(.custom(Cnst.txt.fInterBold, size: 16))
                        .foregroundColor(.N100)
                        .frame(width: 24, height: 24)
                    Image(systemName: "list.bullet.below.rectangle")
                        .font(.custom(Cnst.txt.fInterBold, size: 16))
                        .foregroundColor(.N100)
                        .frame(width: 24, height: 24)
                }
                HStack {
                    TextField("Search Subject", text: .constant(""))
                        .frame(maxWidth: .infinity)
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.N50)
                }
                .font(.custom(Cnst.txt.fInterRegular, size: 14))
                .contentShape(Rectangle())
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.N50, lineWidth: 1)
                )
            }
            .padding()
            Divider()
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: itemColumns, spacing: 24) {
                    ForEach(1...11, id: \.self) { _ in
                        FishItemCardView()
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 24)
            }
        }
    }
    
    func FishItemCardView() -> some View {
        let square = (UIScreen.main.bounds.width - 48) / 2
        return VStack(spacing: 0) {
            Image(Cnst.img.dummyFish)
                .resizable()
                .scaledToFill()
                .frame(width: square, height: square)
                .clipped()
                
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Ikan Bandeng")
                        .font(.custom(Cnst.txt.fInterSemiBold, size: 12))
                        .foregroundColor(.N100)
                    Text("Aceh Kota, Aceh")
                        .font(.custom(Cnst.txt.fInterRegular, size: 10))
                        .foregroundColor(.N50)
                    HStack(spacing: 4) {
                        Image(systemName: "scalemass.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .font(.custom(Cnst.txt.fInterBold, size: 14))
                            .foregroundColor(.R100)
                        Text("40Kg")
                            .font(.custom(Cnst.txt.fInterSemiBold, size: 10))
                            .foregroundColor(.N50)
                    }
                }
                HStack(spacing: 0) {
                    Spacer(minLength: 0)
                    Text("Rp 200.000")
                        .font(.custom(Cnst.txt.fInterBold, size: 14))
                        .foregroundColor(.G100)
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color.N0)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
