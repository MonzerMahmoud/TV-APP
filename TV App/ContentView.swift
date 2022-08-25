//
//  ContentView.swift
//  TV App
//
//  Created by Syber Expertise on 17/06/2022.
//

import SwiftUI
import AVKit
import WebKit
import Foundation

let videoLink = "https://sbfull.com/e/q8zz0qcspl5k.html"

let onePieceCover = "https://mangaplus.shueisha.co.jp/drm/title/100020/title_thumbnail_portrait_list/10711.jpg?key=944fcc1a65d18e23f5184af1ce40133e&duration=86400"
let onePieceMangaCover = "https://animecorner.me/wp-content/uploads/2021/11/voI100-scaled.jpg"

let hunterCover = "https://static.wikia.nocookie.net/disneythehunchbackofnotredame/images/2/20/Hunter_x_Hunter_%282011_Anime%29.jpg/revision/latest?cb=20150828232853"
let hunterMangaCover = "https://i.pinimg.com/originals/bf/9e/1c/bf9e1c72fa66391647562ce0b56b40c7.jpg"

let narutoCover = "https://i.pinimg.com/originals/38/f3/ec/38f3ecf77dc2b5481fcd172f98844c6c.png"
let narutoMangaCover = "https://i.pinimg.com/originals/8f/ee/98/8fee98fb2296d70ddd247a3a0195d7a1.jpg"

let bleachCover = "https://i.pinimg.com/736x/9e/bd/be/9ebdbeac4bb3c3d99c92fc2332886665.jpg"
let bleachMangaCover = "https://i.pinimg.com/550x/72/54/9f/72549ff05089e9d056cead2a58e3fdc9.jpg"

let blackClover = "https://img1.ak.crunchyroll.com/i/spire3/501db6b69ced79e79a556b20cbdb9c5d1609784936_full.jpg"
let blackCloverMangaCover = "https://static.wikia.nocookie.net/blackclover/images/8/82/Volume_8.png/revision/latest/scale-to-width-down/250?cb=20180426231413"

struct ContentView: View {

    var body: some View {
        //VideoPlayer(player: AVPlayer(url: URL(string: videoLink)!))
        //LinkView(link: videoLink)
        HomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WebView: UIViewRepresentable {
    //typealias UIViewType =
    
   var url: URL
   func makeUIView(context: Context) -> WKWebView  {
       let webView = WKWebView()
       let request = URLRequest(url: url)
       webView.load(request)
       return webView
   }
    
   func updateUIView(_ uiView: WKWebView, context: Context) {
   }
}
extension String {
   var embed: String {
       var strings = self.components(separatedBy: "/")
       let videoId = strings.last ?? ""
       strings.removeLast()
       let embedURL = strings.joined(separator: "/") + "embed/\(videoId)"
       return embedURL
   }
}
