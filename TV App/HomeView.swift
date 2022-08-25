//
//  HomeView.swift
//  TV App
//
//  Created by Syber Expertise on 17/06/2022.
//

import SwiftUI

let onePieceBackground = "https://wallpaper.dog/large/20345711.jpg"
let onePieceBackgroundColor = Color(uiColor: UIColor.init(red: 133/256, green: 47/256, blue: 40/256, alpha: 0.8))

let hunterBackround = "https://wallpapercave.com/wp/wp1872041.png"
let hunterBackgroundColor = Color(uiColor: UIColor.init(red: 172/256, green: 155/256, blue: 158/256, alpha: 0.8))

let narutoBackground = "https://wallpapermoon.com/wp-content/uploads/2021/06/naruto-03-2.jpg"
let narutoBackgroundColor = Color(uiColor: UIColor.init(red: 136/256, green: 80/256, blue: 151/256, alpha: 0.8))

let bleachBackground = "https://images3.alphacoders.com/249/2499.jpg"
let bleachBackgroundColor = Color(uiColor: UIColor.init(red: 96/256, green: 100/256, blue: 98/256, alpha: 0.8))

let blackCloverBackground = "https://images3.alphacoders.com/911/911611.png"
let blackCloverBackgroundColor = Color(red: 0.87, green: 0.65, blue: 0.89)

let imagesStrings = [onePieceBackground, blackCloverBackground, narutoBackground, hunterBackround, bleachBackground]
let backgroundColors = [onePieceBackgroundColor, blackCloverBackgroundColor, narutoBackgroundColor, hunterBackgroundColor, bleachBackgroundColor]
let coversStrings = [onePieceCover, blackClover, narutoCover, hunterCover, bleachCover]

let animeSamples: [Anime] = [Anime(name: "One Piece", imageString: onePieceCover, mangaString: onePieceMangaCover), Anime(name: "Black Clover", imageString: blackClover, mangaString: blackCloverMangaCover), Anime(name: "Naruto", imageString: narutoCover, mangaString: narutoMangaCover), Anime(name: "HunterXHunter", imageString: hunterCover, mangaString: hunterMangaCover), Anime(name: "Bleach", imageString: bleachCover, mangaString: bleachMangaCover)]


struct HomeView: View {
    
    
    var body: some View {
        NavigationView {
            HomeBodyView()
                .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

fileprivate struct HomeMainSlider: View {
    public let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var selection = 0
    @ObservedObject var homeVariables: HomeVariables
    
    
    var body: some View {
        ZStack{
            
            TabView(selection : $selection){
                ForEach(0..<5){ i in
                    AsyncImage(url: URL(string: imagesStrings[i])!, transaction: Transaction(animation: .easeInOut)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .onAppear(perform: {
                                    
                                })
                        case .failure(_):
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }

                }
            }.tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .onReceive(timer, perform: { _ in
                    withAnimation{
                        selection = selection < 4 ? selection + 1 : 0
                        homeVariables.backgroundColor = backgroundColors[selection]
                    }
                })
        }
    }
}

fileprivate struct HomeBodyView: View {
    @StateObject var homeVariables = HomeVariables()
    
    var body: some View {
        ScrollView {
            HomeMainSlider(homeVariables: homeVariables)
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.size.height / 4)
                .cornerRadius(25)
                .shadow(radius: 15)
            
//            ScrollView(.vertical, showsIndicators: false) {
//                VStack {
//                    BodySection(sectionName: "Anime Series", sectionElements: animeSamples, sectionType: .animeSeries)
//                    BodySection(sectionName: "Anime Manga", sectionElements: animeSamples, sectionType: .animeManga)
//                }
//                .padding(.top, 30)
//            }
//
//            Spacer()
        }
        .padding()
        .navigationTitle("Home").font(.largeTitle)
        .background(homeVariables.backgroundColor)
    }
}

fileprivate class HomeVariables: ObservableObject{
    @Published var backgroundColor = Color.white
}

extension UIImage {
    /// Average color of the image, nil if it cannot be found
    var averageColor: UIColor? {
        // convert our image to a Core Image Image
        guard let inputImage = CIImage(image: self) else { return nil }

        // Create an extent vector (a frame with width and height of our current input image)
        let extentVector = CIVector(x: inputImage.extent.origin.x,
                                    y: inputImage.extent.origin.y,
                                    z: inputImage.extent.size.width,
                                    w: inputImage.extent.size.height)

        // create a CIAreaAverage filter, this will allow us to pull the average color from the image later on
        guard let filter = CIFilter(name: "CIAreaAverage",
                                  parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        // A bitmap consisting of (r, g, b, a) value
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])

        // Render our output image into a 1 by 1 image supplying it our bitmap to update the values of (i.e the rgba of the 1 by 1 image will fill out bitmap array
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)

        // Convert our bitmap images of r, g, b, a to a UIColor
        return UIColor(red: CGFloat(bitmap[0]) / 255,
                       green: CGFloat(bitmap[1]) / 255,
                       blue: CGFloat(bitmap[2]) / 255,
                       alpha: CGFloat(bitmap[3]) / 255)
    }
}

struct BodySection: View {
    var sectionName: String = ""
    var sectionElements: [Anime] = []
    var sectionType: SectionType
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(sectionName)
                    .font(.title2)
                .fontWeight(.bold)
                
                Spacer()
                
                NavigationLink(destination: AnimeSeriesView(), label: {
                    Text("More")
                        .font(.title2)
                        .fontWeight(.medium)
                })
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15){
                    ForEach(0..<5){ i in
                        HomeElementsViews(anime: sectionElements[i], sectionType: sectionType)
                    }
                }
                
            }
            
        }
    }
}

struct HomeElementsViews: View {
    var anime: Anime = Anime()
    var sectionType: SectionType
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: sectionType == .animeSeries ? anime.imageString : anime.mangaString)!, transaction: Transaction(animation: .easeInOut)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 140, maxHeight: 180)
                        .onAppear(perform: {
                            
                        })
                case .failure(_):
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            .cornerRadius(25)
            .shadow(radius: 5)
            
            Text(anime.name)
                .font(.title3)
                .fontWeight(.bold)
        }
    }
}

struct Anime {
    var name: String
    var imageString: String
    var mangaString: String
    
    init() {
        self.name = ""
        self.imageString = ""
        self.mangaString = ""
    }
    
    init(name: String, imageString: String, mangaString: String) {
        self.name = name
        self.imageString = imageString
        self.mangaString = mangaString
    }
}

enum SectionType {
    case animeSeries
    case animeManga
}
