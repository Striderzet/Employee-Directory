//
//  Extensions.swift
//  Employee Directory
//
//  Created by Tony Buckner on 9/9/24.
//

import Foundation
import SwiftUI
import UIKit

// MARK: SwiftUI IMage Extension
extension Image {
    @MainActor
    func getUIImage() -> UIImage? {
        let image = resizable()
            .scaledToFill()
            .clipped()
        return ImageRenderer(content: image).uiImage
    }
}
