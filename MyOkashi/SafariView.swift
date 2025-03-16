//
//  SafariView.swift
//  MyOkashi
//
//  Created by ピットラボ on 2025/03/02.
//

import SwiftUI
import SafariServices

//  お菓子をタップしたらWebページを表示する
struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}
