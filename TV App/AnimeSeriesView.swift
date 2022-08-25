//
//  AnimeSeriesView.swift
//  TV App
//
//  Created by Syber Expertise on 17/06/2022.
//

import SwiftUI

struct AnimeSeriesView: View {
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        //VideoPlayer(player: AVPlayer(url: URL(string: videoLink)!))
        //LinkView(link: videoLink)
        NavigationView {
            List {
                EntityCard()
                EntityCard()
                EntityCard()
            }
            .navigationTitle("Anime Series")
            .navigationBarHidden(true)
        }
    }
}

struct AnimeSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeSeriesView()
    }
}

struct LinkView: View {
   var link: String
   var body: some View {
       WebView(url: URL(string: link.embed)!)
   }
}

struct EntityCard: View {
    var imageUrl: String = onePieceCover
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageUrl)!) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                    
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 250)
                        .cornerRadius(30)
                case .failure(_):
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading) {
                Text("One Piece")
                    .font(.headline)
                    .fontWeight(.heavy)
                
                Text("Echiro Oda")
                    .font(.body)
                
                Text("1020 EP")
                    .font(.body)
                
                Text("9.7/10")
                    .font(.body)
                    .fontWeight(.thin)
                    .foregroundColor(.red)
                
            }
            
            Spacer()
        }
    }
}
