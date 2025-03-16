//
//  OkashiData.swift
//  MyOkashi
//
//  Created by ピットラボ on 2025/03/02.
//

import SwiftUI

struct OkashiItem: Identifiable {
    let id = UUID()
    let name: String
    let link: URL
    let image: URL
}

//  お菓子データ検索用クラス
@Observable class OkashiData {
    
    struct ResultJson: Codable {
        
        struct Item: Codable {
            let name: String?
            let url: URL?
            let image: URL?
        }
        let item: [Item]?
    }
    
    var okashiList: [OkashiItem] = []
    
    var okashiLink: URL?
    
    func searchOkashi(keyword: String) {
        
        Task {
            await search(keyword: keyword)
        }
    }
    
    //  WebAPI検索用メソッド
    //  keyword 検索したいワード
    @MainActor
    private func search(keyword: String) async {
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            return
        }
        
        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r") else {
            return
        }
        
        print(req_url)
        
        do {
            let (data, _) = try await URLSession.shared.data(from: req_url)
            
            let decoder = JSONDecoder()
            
            let json = try decoder.decode(ResultJson.self, from: data)
            
//            print(json)
            
            //  情報の取得ができているか確認
            guard let items = json.item else {return}
            
            okashiList.removeAll()
            
            for item in items {
                if let name = item.name,
                   let link = item.url,
                   let image = item.image {
                    let okashi = OkashiItem(name: name, link: link, image: image)
                    
                    okashiList.append(okashi)
                }
            }
            
            print(okashiList)
            
        } catch {
            print("エラーが出ました")
        }
    }
}
