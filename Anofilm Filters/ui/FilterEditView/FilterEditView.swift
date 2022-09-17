//
//  FilterEditView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 5.09.2022.
//

import SwiftUI

struct FilterEditView: View {

    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @Environment(\.presentationMode) private var presentationMode

    @State private var showFiltersSheet = false
    @State private var showImagePickerSheet = false
    @State private var showSaveDialog = false
    @State private var showPhotoLibraryAdditionPermissionDeniedDialog = false
    @State private var showSavedToDocumentsToastMessage = false
    @State private var imageChosen: (image: UIImage?, orientation: UIImage.Orientation?)?

    var filterIndex: Int = -1

    @StateObject var filterEditViewModel: FilterEditViewModel = FilterEditViewModel()
    @EnvironmentObject var filtersViewModel: FiltersViewModel


    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    FilterImageView(imageToDisplay: $filterEditViewModel.outputImage)
                        .gesture(imageViewPressGesture)
                    editContent
                        .padding()
                        .frame(
                        width: geometry.size.width,
                        height: geometry.size.height * 0.3,
                        alignment: .center
                    )
                }
                CustomizableDialog(showDialog: $showSaveDialog, content: createSaveDialogContent)
                CustomizableDialog(showDialog: $showPhotoLibraryAdditionPermissionDeniedDialog, content: createPhotoLibraryAdditionPermissionDeniedDialogContent)
                ToastMessage(showMessage: $showSavedToDocumentsToastMessage) {
                    toastContent
                }
            }

        }
            .onAppear {
            if filtersViewModel.filters.indices.contains(filterIndex) {
                filterEditViewModel.updateFilter(filter: filtersViewModel.filters[filterIndex])
            }
        }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: createToolbarContent)
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showFiltersSheet, onDismiss: nil, content: createFiltersList)
            .sheet(isPresented: $showImagePickerSheet, onDismiss: nil, content: createImagePicker)
            .onChange(of: imageChosen?.image, perform: { newValue in
            filterEditViewModel.changeOriginalImage(with: imageChosen?.image, orientation: imageChosen?.orientation)
        })


    }
    
    private var editContent: some View {
        EditContentView(filterEditViewModel: filterEditViewModel)
    }



    private var toastContent: some View {
        Text("Image saved to gallery!")
            .padding()
            .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
        )
            .font(.largeTitle)
            .shadow(radius: 8)
    }

    @ToolbarContentBuilder private func createToolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .automatic) {
            Menu {
                saveImageButton
                saveFilterButton
                imagePickerButton
                chooseFilterButton
            } label: {
                Image(systemName: "list.bullet")
            }
        }
        ToolbarItem(placement: .navigationBarLeading) {
            backButton
        }
    }

    private var backButton: some View {
        Button {
            showSaveDialog = true
        } label: {
            Label("Filters", systemImage: "chevron.left")
        }

    }

    private var chooseFilterButton: some View {
        Button {
            showFiltersSheet = true
        } label: {
            Label("Choose filter type", systemImage: "camera.filters")
        }

    }

    private var imagePickerButton: some View {
        Button {
            showImagePickerSheet = true
        } label: {
            Label("Change photo", systemImage: "photo")
        }
    }

    private var saveFilterButton: some View {
        Button {
            showSaveDialog = true
        } label: {
            Label("Save Filter", systemImage: "square.and.arrow.down")
        }
    }

    private var saveImageButton: some View {
        Button {
            let permissionManager = PhotosLibraryPermissionManager {
                filterEditViewModel.saveImageToDocuments {
                    withAnimation {
                        showSavedToDocumentsToastMessage = true
                    }
                }
            } onDenied: {
                showPhotoLibraryAdditionPermissionDeniedDialog = true
            }
            permissionManager.requestPhotosLibraryAdditionPermission()
        } label: {
            Label("Save image to gallery", systemImage: "square.and.arrow.down.on.square.fill")
        }
    }


    private func createFiltersList() -> some View {
        VStack {
            HStack {
                Spacer()
                Button("Done") {
                    showFiltersSheet = false
                }
            }
                .padding()
            List(EditType.allCases) { editType in
                Button {
                    filterEditViewModel.editType = editType
                    showFiltersSheet = false
                } label: {
                    Text(editType.rawValue.capitalized)
                }

            }
        }
    }

    @ViewBuilder private func createPhotoLibraryAdditionPermissionDeniedDialogContent() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
            VStack {
                Text("You denied permission to save photos to your library.")
                Text("You need to go to settings to enable it.")
                Link("Open settings", destination: URL(string: UIApplication.openSettingsURLString)!)
                    .padding()
            }.padding()
        }.frame(width: 250, height: 300, alignment: .center)
    }

    @ViewBuilder private func createSaveDialogContent() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(colorScheme == .light ? .white : .black)
            VStack {
                Text("Save your filter")
                TextField(
                    "Filter Name",
                    text: $filterEditViewModel.filterName
                )
                Spacer()
                HStack {
                    Button {
                        showSaveDialog = false
                        if let storedFilter = filterEditViewModel.storedFilter, filtersViewModel.filters.indices.contains(filterIndex) {
                            filtersViewModel.filters[filterIndex] = storedFilter
                        }
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    Spacer()
                    Button {
                        showSaveDialog = false
                        filterEditViewModel.filter.name = filterEditViewModel.filterName
                        if filterIndex == -1 {
                            filtersViewModel.filters.append(filterEditViewModel.filter)
                        } else {
                            filtersViewModel.filters[filterIndex] = filterEditViewModel.filter
                        }
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }.padding()
        }.frame(width: 250, height: 300, alignment: .center)
    }

    private func createImagePicker() -> some View {
        ImagePicker(imageWithOrientation: $imageChosen)
    }

    private var imageViewPressGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { _ in
            filterEditViewModel.showOriginalImage()
        }
            .onEnded { _ in
            filterEditViewModel.showFilteredImage()
        }
    }


}
