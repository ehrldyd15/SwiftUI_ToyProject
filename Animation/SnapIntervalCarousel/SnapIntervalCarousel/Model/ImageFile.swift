//
//  ImageFile.swift
//  SnapIntervalCarousel
//
//  Created by Do Kiyong on 2023/08/24.
//

import SwiftUI

// Image Model
struct ImageFile: Identifiable {
    var id: UUID = .init()
    var imageName: String
    var thumbnail: UIImage?
}
