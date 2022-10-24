//
//  AddContentView.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import SwiftUI

struct AddContentView: View {
    let optionArea: [OptionAreaResponse]
    let optionSize: [OptionSizeResponse]
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var keyboard = KeyboardResponder()
    @StateObject private var viewModel = AddContentViewModel()
    @State private var nameFish: String = ""
    @State private var priceFish: String = ""
    @State private var selectArea: OptionAreaResponse = OptionAreaResponse()
    @State private var selectSize: OptionSizeResponse = OptionSizeResponse()
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Image(Cnst.img.dummyFish)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2, alignment: .bottom)
                        .clipped()
                    
                    //Nama Ikan
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Posisi Area Ikan")
                                .font(.custom(Cnst.txt.fInterSemiBold, size: 12))
                                .foregroundColor(.N100)
                            Text("Wajib diisi")
                                .font(.custom(Cnst.txt.fInterRegular, size: 10))
                                .foregroundColor(.G100)
                        }
                        TextField("Masukkan Nama Ikan", text: $nameFish)
                            .frame(maxWidth: .infinity)
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
                    
                    //Area
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Posisi Area Ikan")
                                .font(.custom(Cnst.txt.fInterSemiBold, size: 12))
                                .foregroundColor(.N100)
                            Text("Wajib pilih 1")
                                .font(.custom(Cnst.txt.fInterRegular, size: 10))
                                .foregroundColor(.G100)
                        }
                        ForEach(optionArea, id: \.city) { area in
                            HStack {
                                let slct = selectArea == area
                                Image(systemName: slct ? "record.circle": "circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(slct ? .R100: .N50)
                                    .frame(width: 24, height: 24)
                                Text("\(area.city!.capitalized), \(area.province!.capitalized)")
                                    .font(.custom(Cnst.txt.fInterRegular, size: 14))
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation {
                                    selectArea = area
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //Ukuran
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Ukuran Ikan")
                                .font(.custom(Cnst.txt.fInterSemiBold, size: 12))
                                .foregroundColor(.N100)
                            Text("Wajib pilih 1")
                                .font(.custom(Cnst.txt.fInterRegular, size: 10))
                                .foregroundColor(.G100)
                        }
                        ForEach(optionSize, id: \.size) { sz in
                            HStack {
                                let slct = selectSize == sz
                                Image(systemName: slct ? "record.circle": "circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(slct ? .R100: .N50)
                                    .frame(width: 24, height: 24)
                                Text("Ukuran \(sz.size)")
                                    .font(.custom(Cnst.txt.fInterRegular, size: 14))
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation {
                                    selectSize = sz
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            HStack(spacing: 24) {
                let ignre = !nameFish.isEmpty && !priceFish.isEmpty && !(selectArea.city?.isEmpty ?? false) && !selectSize.size.isEmpty
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text("Harga Ikan")
                            .font(.custom(Cnst.txt.fInterRegular, size: 12))
                            .foregroundColor(.N50)
                        Circle()
                            .frame(width: 4, height: 4)
                            .foregroundColor(.N50)
                        Text("Wajib diisi")
                            .font(.custom(Cnst.txt.fInterRegular, size: 10))
                            .foregroundColor(.G100)
                    }
                    
                    VStack(spacing: 0) {
                        TextField("Masukkan Harga", text: $priceFish)
                            .font(.custom(Cnst.txt.fInterBold, size: 16))
                            .foregroundColor(.N100)
                            .keyboardType(.numberPad)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.N50.opacity(0.4))
                    }
                }
                .frame(maxWidth: .infinity)

                Button {
                    if ignre {
                        let req = NewFishStructModel(komoditas: nameFish, provinsi: selectArea.province!, kota: selectArea.city!, size: selectSize.size, price: priceFish.replacingOccurrences(of: "Rp ", with: "").replacingOccurrences(of: ".", with: ""))
                        viewModel.AddRowsToList(req: req)
                    }
                } label: {
                    Text("Tambah")
                        .font(.custom(Cnst.txt.fInterSemiBold, size: 14))
                        .padding(.vertical)
                        .padding(.horizontal, 32)
                        .foregroundColor(ignre ? .N100: .N50)
                        .background(ignre ? Color.G100: Color.N50.opacity(0.2))
                        .cornerRadius(100)
                }
            }
            .padding()
            .padding(.bottom, keyboard.currentHeight == 0 ? GetHeightSafeArea(): 0)
            .background(Color.N0)
            .clipped()
            .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 0)
        }
        .contentShape(Rectangle())
        .padding(.bottom, keyboard.currentHeight)
        .navigationBarTitle("", displayMode: .inline)
        .ignoresSafeArea(.all, edges: .vertical)
        .onChange(of: viewModel.succesAddNewFish) { nv in
            if nv {
                dismiss()
            }
        }
        .onChange(of: priceFish) { nv in
            let deflt = nv.replacingOccurrences(of: "Rp ", with: "").replacingOccurrences(of: ".", with: "")
            priceFish = deflt.isEmpty ? "": deflt.toRupiah
        }
        .onAppear {
            UINavigationBar.appearance().tintColor = .white
        }
        .onTapGesture {
            withAnimation {
                UIApplication.shared.endEditing()
            }
        }
    }
}

struct AddContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddContentView(optionArea: [], optionSize: [])
    }
}

/*
 "komoditas": "Sarden",
 "area_provinsi": "JAWA TIMUR",
 "area_kota": "SITUBONDO",
 "size": "30",
 "price": "200000",
 */
