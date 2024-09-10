//
//  QuickCache.swift
//  Employee Directory
//
//  Created by Tony Buckner on 9/9/24.
//

import Foundation
import SwiftUI
import UIKit

struct QuickCache {
    
    private static var imageCache = NSCache<NSURL, UIImage>()
    
    @MainActor
    static func loadImage(withURL urlString: String) -> any View {
        
        let url = URL(string: urlString) ?? URL(fileURLWithPath: "")
        
        if let cachedImage = imageCache.object(forKey: url as NSURL) {
            
            return Image(uiImage: cachedImage)
                .resizable()
            
        } else {
            
            return AsyncImage(url: url, content: { image in
                image
                    .resizable()
                    .onAppear(perform: {
                        let newImage = image.getUIImage()!
                        imageCache.setObject(newImage, forKey: url as NSURL)
                    })
            }, placeholder: {
                Image(systemName: "person")
                    .resizable()
                    .background(.blue)
            })
            
        }
        
    }
    
}
