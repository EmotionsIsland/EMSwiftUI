//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<VM: FilterViewModel>: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: VM

    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            header

            ZStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                case .error(let message):
                    errorView(message: message)

                case .content:
                    content
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

private extension FilterScreen {
    var header: some View {
        VStack {
            ZStack {
                Text("Filters")
                    .font(.SFPro.headline2)
                    .foregroundStyle(.blackBase)

                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.blackBase)
                    }
                }
            }
            .frame(minHeight: 30)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)

            Divider()
                .background(Color.grayBase)
        }
        .background(Color.white)
    }

    var content: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                FilterSelectionSection(viewModel: viewModel)

                Divider()
                    .padding(.bottom, 18)
                
                ForEach(viewModel.sortedGroupTitles, id: \.self) { group in
                    FilterGroupSection(viewModel: viewModel, group: group)
                }
            }
            .padding([.horizontal, .bottom], 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    func errorView(message: String) -> some View {
        VStack(spacing: 12) {
            Text(message)
                .font(.SFPro.bodyNormal)
                .foregroundStyle(.blackBase)
                .multilineTextAlignment(.center)

            Button(
                action: { viewModel.retry() },
                label: {
                    Text("Повторить")
                        .font(.SFPro.bodyNormal)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.orangeBase)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            )
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
