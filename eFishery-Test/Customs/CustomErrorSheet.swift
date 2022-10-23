//
//  CustomErrorSheet.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import SwiftUI

struct CustomErrorSheet: View {
    @Binding var isShowing: Bool
    @Binding var err: NetworkError
    
    var body: some View {
        VStack(spacing: 30) {
            Capsule()
                .fill(Color.N50)
                .frame(width: 32, height: 5)
                
            VStack(spacing: 16) {
                Image(ImageOfError())
                Text(TittleOfError())
                    .font(.custom(Cnst.txt.fInterSemiBold, size: 16))
                Text(BodyOfError())
                    .font(.custom(Cnst.txt.fInterRegular, size: 12))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, -8)
                
                Button {
                    DismissErrorSheet()
                    //switch err {
                    //case .badConnection:
                    //DismissErrorSheet()
                    //default:
                    //exit(0)
                    //}
                } label: {
                    Text("Oge")
                        .font(.custom(Cnst.txt.fInterSemiBold, size: 14))
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.N0)
                        .background(Color.R100)
                        .cornerRadius(30)
                }
                .padding(.top)
            }
        }
        .foregroundColor(.N100)
        .padding(.bottom, GetHeightSafeArea())
        .padding()
        .onDisappear { DismissErrorSheet() }
    }
    
    private func TittleOfError() -> String {
        switch err {
        case .badConnection:
            return "Koneksi internet tidak ditemukan"
        case .decodeFail:
            return "Gagal memproses data"
        default:
            return "Sistem sedang gangguan"
        }
    }
    private func BodyOfError() -> String {
        switch err {
        case .badConnection:
            return "Tenangn saja, Cek koneksi internetmu yaa.\nKamu tetap bisa menggunakan applikasi ini."
        case .decodeFail:
            return "Terjadi kesalahan proses data.\nMohon maaf, ya."
        default:
            return "Mohon maaf ada gangguan di sistem.\nCoba lagi atau kembali nanti, ya."
        }
    }
    private func ImageOfError() -> String {
        switch err {
        case .badConnection:
            return Cnst.img.errorConnection
        case .decodeFail:
            return Cnst.img.errorDecodeFailed
        default:
            return Cnst.img.errorSystem
        }
    }
    private func DismissErrorSheet() {
        withAnimation(.easeOut) {
            isShowing = false
        }
    }
}
