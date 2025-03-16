//
//  ContentView.swift
//  MyOkashi
//
//  Created by ピットラボ on 2025/03/02.
//

import SwiftUI

struct ContentView: View {
    var okashiDataList = OkashiData()
    
    //  入力中の文字列を保持する変数
    @State var inputText = ""
    
    //  SafariViewの表示有無を管理する変数
    @State var isShowSafari = false
    
    var body: some View {
        VStack {
            TextField("キーワード", text: $inputText, prompt: Text("キーワードを入力してください ") )
            
            //  入力完了したので検索
            .onSubmit {
                okashiDataList.searchOkashi(keyword: inputText)
            }
            //  改行を検索に変更
            .submitLabel(.search)
            .padding()
            
            List(okashiDataList.okashiList) {
                okashi in 
                
                Button {
                    okashiDataList.okashiLink = okashi.link
                    isShowSafari.toggle()
                } label: {
                    HStack {
                        AsyncImage(url: okashi.image) {
                            image in image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(okashi.name)
                    }
                }
            }
            
            .sheet(isPresented: $isShowSafari, content: {
                SafariView(url: okashiDataList.okashiLink!)
                    .ignoresSafeArea(edges: [.bottom])
            })
        }
    }
}

#Preview {
    ContentView()
}
