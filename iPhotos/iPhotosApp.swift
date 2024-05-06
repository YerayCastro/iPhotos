//
//  iPhotosApp.swift
//  iPhotos
//
//  Created by Yery Castro on 30/4/24.
//

import SwiftUI
import SwiftData

@main
struct iPhotosApp: App {
    var body: some Scene {
        WindowGroup {
            PhotosListView()
        }
        .modelContainer(for: SampleModel.self)
    }
}
