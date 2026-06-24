//
//  ListCharactersView.swift
//  RickAndMortyWiki
//
//  Created by Admin on 23/06/2026.
//

import SwiftUI

struct ListCharactersView: View {
    @State private var viewModel = ListCharactersViewModelProvider.provide()
    
    var body: some View {
        List {
            ForEach(viewModel.charactersList.indices, id: \.self) { index in
                CharacterView(rmCharacter: viewModel.charactersList[index])
                    .onAppear {
                        if index == viewModel.charactersList.count - 1 {
                            Task {
                                await viewModel.fetchCharacters()
                            }
                        }
                    }
            }
            
            if viewModel.isLoadingNextPage {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        .overlay {
            if viewModel.charactersList.isEmpty
                && !viewModel.isLoadingNextPage
                && viewModel.errorMessage.isEmpty {
                Text("No characters to show.")
            }
        }
        .task {
            await viewModel.fetchCharacters()
        }
        .refreshable {
            await viewModel.refresh()
        }
        .alert(
            "Error",
            isPresented: Binding(
                get: { !viewModel.errorMessage.isEmpty },
                set: { if !$0 { viewModel.clearError() } }
            )
        ) {
            Button("Retry") {
                Task {
                    await viewModel.fetchCharacters()
                }
            }
            Button("Dismiss",
                   role: .cancel,
                   action: {})
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

#Preview {
    ListCharactersView()
}
