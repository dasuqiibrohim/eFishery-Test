//
//  ContentView.swift
//  eFishery-Test
//
//  Created by ACI 2 on 21/10/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State var sliderPosition: ClosedRange<Float> = 0...1000000
    @State private var showFilter = false
    private let itemColumns = [GridItem(.flexible()),
                                GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 0) {
            //Header
            VStack(spacing: 16) {
                HStack {
                    Text("List Perikanan di Indonesia")
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
                        .onTapGesture {
                            withAnimation {
                                showFilter = true
                            }
                        }
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
            
            if viewModel.myListFish.isEmpty {
                ListNotFoundView()
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: itemColumns, spacing: 24) {
                        ForEach(viewModel.myListFish) { fish in
                            FishItemCardView()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 24)
                }
                .redacted(reason: viewModel.shmrAll ? .placeholder: [])
            }
        }
        .navigationBarHidden(true)
        .overlay { CustomSheetShowHide(show: $showFilter) { ListFishilterSortSheet() } }
        .onAppear {
            viewModel.GetReadDataFromList()
            //viewModel.GetReadDataFromOptionArea()
            //viewModel.GetReadDataFromSize()
        }
    }
    
    private func ListNotFoundView() -> some View {
        VStack(spacing: 24) {
            Image(Cnst.img.listEmpty)
            Text("Belum ada list perikanan")
                .font(.custom(Cnst.txt.fInterSemiBold, size: 14))
                .foregroundColor(.N50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    private func FishItemCardView() -> some View {
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
    private func ListFishilterSortSheet() -> some View {
        return VStack(spacing: 0) {
            Capsule()
                .fill(Color.N50)
                .frame(width: 32, height: 5)
                .padding(8)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("Filter dan Urutkan")
                            .font(.custom(Cnst.txt.fInterBold, size: 16))
                        Spacer()
                        Text("Reset")
                            .underline()
                            .font(.custom(Cnst.txt.fInterRegular, size: 14))
                            .foregroundColor(.R100)
                    }
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Urutkan berdasarkan...")
                                .font(.custom(Cnst.txt.fInterSemiBold, size: 14))
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(1...4, id: \.self) { _ in
                                    HStack {
                                        //let slct = selectSortingResto == srt
                                        //Image(systemName: slct ? "record.circle": "circle")
                                        Image(systemName: "circle")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            //.foregroundColor(slct ? .JKP100: .JKB50)
                                            .foregroundColor(.R100)
                                            .frame(width: 24, height: 24)
                                        Text("Harga terendah")
                                            .font(.custom(Cnst.txt.fInterRegular, size: 14))
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        withAnimation {
                                            //selectSortingResto = srt
                                        }
                                    }
                                }
                            }
                        }
                        
                        Capsule()
                            .foregroundColor(.N100)
                            .frame(height: 1)
                        
                        VStack(alignment: .leading, spacing: 36) {
                            Text("Hanya tampilkan dengan harga...")
                                .font(.custom(Cnst.txt.fInterSemiBold, size: 14))
                            CustomRangedSliderView(value: $sliderPosition, bounds: 0...1000000)
                        }
                    }
                }
                .padding()
            }
            
            Button {
                withAnimation {
                    showFilter = false
                }
            } label: {
                Text("Tampilkan Hasil")
                    .font(.custom(Cnst.txt.fInterSemiBold, size: 14))
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.N0)
                    .background(Color.R100)
                    .cornerRadius(30)
                    .padding()
                    .padding(.bottom, GetHeightSafeArea())
                    .background(Color.N0)
                    .clipped()
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 0)
            }
        }
        .frame(height: 450 + (GetHeightSafeArea() ?? 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
