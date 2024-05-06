//
//  ContentView.swift
//  iPhotos
//
//  Created by Yery Castro on 30/4/24.
//

import SwiftUI
import SwiftData

struct PhotosListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SampleModel.name) var samples: [SampleModel]
    @State private var formType: ModelFormType?
    
    var body: some View {
        NavigationStack {
            Group {
                if samples.isEmpty {
                    ContentUnavailableView("Add your first photo", systemImage: "photo")
                } else {
                    List(samples) { sample in
                        NavigationLink(value: sample) {
                            HStack {
                                Image(uiImage: sample.image == nil ? Constants.placeholder : sample.image!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .padding(.trailing)
                                Text(sample.name)
                                    .font(.title)
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                modelContext.delete(sample)
                                try? modelContext.save()
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationDestination(for: SampleModel.self) { sample in
                SampleView(sample: sample)
            }
            .navigationTitle("Picker or Camera")
            .toolbar {
                Button {
                    formType = .new
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .sheet(item: $formType) { $0 }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PhotosListView()
            .modelContainer(SampleModel.preview)
    }
}
