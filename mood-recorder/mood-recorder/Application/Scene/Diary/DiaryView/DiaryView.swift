//
//  DiaryView.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import SwiftUI

struct DiaryView: View {
    private enum ScrollDestination {
        case top
        case bottom
    }
    
    @ObservedObject
    var viewModel: BaseViewModel<DiaryState,
                                 DiaryTrigger>
    
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = Settings.themeId.value
    
    @FocusState
    private var isFocus: Bool
    
    @State
    private var text = ""
    
    @State
    private var isImagePickerShowing = false
    
    @State
    private var destination: ScrollDestination?
    
    @State
    private var imagePickerController: UIImagePickerController?
    
    let onClose: VoidFunction
    
    init(viewModel: BaseViewModel<DiaryState, DiaryTrigger>,
         onClose: @escaping VoidFunction) {
        self.viewModel = viewModel
        self.onClose = onClose
    }
    
    // MARK: - Icon background color
    func iconBackgroundColor(_ isSelected: Bool) -> Color {
        return isSelected ?
        Theme.get(id: themeId).buttonColor.backgroundColor :
        Theme.get(id: themeId).buttonColor.disableColor
    }
    
    // MARK: - Section Icon Type
    func getIconGrid(optionModels: [OptionModel], at sectionIndex: Int) -> some View {
        return LazyVGrid(columns: Array(repeating: GridItem(.flexible(),
                                                            alignment: .top),
                                        count: 5),
                         content: {
            ForEach(Array(optionModels.enumerated()),
                    id: \.offset) { optionIndex, optionModel in
                LazyVStack(spacing: 5) {
                    Button(action: {
                        isFocus = false
                        viewModel.trigger(.optionTap(sectionIndex: sectionIndex,
                                                     optionIndex: optionIndex))
                    }, label: {
                        RoundImageView(image: optionModel.content.image.value.image,
                                       backgroundColor: iconBackgroundColor(optionModel.isSelected))
                    })
                        .aspectRatio(1, contentMode: .fit)
                        .saturation(optionModel.isSelected ? 1 : 0)
                        .buttonStyle(ResizeAnimationButtonStyle())
                        .animation(Animation.easeInOut, value: optionModel.isSelected)
                    
                    if optionModel.content.title != "" {
                        Text(optionModel.content.title)
                            .foregroundColor(Theme.get(id: themeId).tableViewColor.text)
                            .font(.system(size: 12))
                    }
                }
            }
        })
    }
    
    // MARK: - Section Emotion Type
    func getEmotionContentType(emotion: CoreEmotion,
                               sectionIndex: Int) -> some View {
        return LazyVGrid(columns: Array(repeating: GridItem(.flexible(),
                                                            alignment: .top),
                                        count: 5),
                         content: {
            ForEach(CoreEmotion.allCases,
                    id: \.rawValue) { coreEmotion in
                Button(action: {
                    isFocus = false
                    viewModel.trigger(.emotionSelected(sectionIndex: sectionIndex,
                                                       emotion: coreEmotion))
                }, label: {
                    RoundImageView(image: coreEmotion.image,
                                   backgroundColor: iconBackgroundColor(coreEmotion == emotion))
                })
                    .aspectRatio(1, contentMode: .fit)
                    .saturation(coreEmotion == emotion ? 1 : 0)
                    .buttonStyle(ResizeAnimationButtonStyle())
                    .animation(Animation.easeInOut, value: coreEmotion == emotion)
            }
        })
    }
    
    // MARK: - Section Image Type
    func getImageContentCell(imageModel: ImageModel,
                             sectionIndex: Int) -> some View {
        Button(action: {
            isFocus = false
            isImagePickerShowing.toggle()
        }, label: {
            ZStack {
                Theme.get(id: themeId).commonColor.textBackground
                if imageModel.isHavingData {
                    imageModel.image?
                        .resizable()
                        .renderingMode(.original)
                } else {
                    VStack {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Theme.get(id: themeId).tableViewColor.text)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        Text("Select a photo")
                            .foregroundColor(Theme.get(id: themeId).tableViewColor.text)
                    }
                }
                
            }
            .aspectRatio(imageModel.aspectRatio, contentMode: .fit)
            .cornerRadius(10)
        })
            .buttonStyle(ResizeAnimationButtonStyle())
            .sheet(isPresented: $isImagePickerShowing) {
                if let imagePickerController = imagePickerController {
                    ImagePicker(sourceType: .photoLibrary, controller: imagePickerController) { image in
                        viewModel.trigger(.pictureSelected(sectionIndex: sectionIndex,
                                                           image: image))
                    }
                } else {
                    SizedBox()
                }
            }
    }
    
    // MARK: - Section Text Type
    func getTextView(textModel: TextModel,
                     sectionIndex: Int) -> some View {
        ZStack {
            Theme.get(id: themeId).commonColor.textBackground
            TextEditor(text: $text)
                .foregroundColor(Theme.get(id: themeId).tableViewColor.text)
                .font(.system(size: 12))
                .padding()
                .focused($isFocus)
            Text(textModel.text ?? "")
                .opacity(0)
                .font(.system(size: 12))
                .padding(.all, 8)
                .padding()
        }
        .cornerRadius(10)
        .frame(minHeight: 200)
        .onChange(of: text) { newValue in
            viewModel.trigger(.onTextChange(sectionIndex: sectionIndex,
                                            text: newValue))
        }.onAppear {
            text = textModel.text ?? ""
        }
    }
    
    // MARK: - Section Sleep Scheldule Type
    func getSleepScheduleText(model: SleepSchelduleModel) -> some View {
        ZStack {
            Theme.get(id: themeId).commonColor.textBackground
            Text(model.displayString)
                .foregroundColor(Theme.get(id: themeId).tableViewColor.text)
                .font(.system(size: 12))
                .padding()
        }
        .cornerRadius(10)
        .frame(minHeight: 50)
    }
    
    // MARK: - Section Content
    @ViewBuilder
    func getSectionContent(at sectionModel: SectionModel, index: Int) -> some View {
        switch sectionModel.cell {
        case let emotion as CoreEmotion:
            getEmotionContentType(emotion: emotion, sectionIndex: index)
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
        case let models as [OptionModel]:
            let datasource = sectionModel.section == .custom ? models.filter { $0.isVisible } : models
            
            VStack {
                getIconGrid(optionModels: datasource,
                            at: index)
                    .padding(.horizontal, 10)
                    .disabled(!sectionModel.isVisible || viewModel.isInEditMode)
                SizedBox(height: 10)
                if sectionModel.isEditable && sectionModel.isVisible && viewModel.isInEditMode {
                    Button(action: {
                        viewModel.trigger(.onOpenCustomizeSectionDialog(model: sectionModel))
                        viewModel.trigger(.handleCustomDialog(status: .open))
                    }, label: {
                        ZStack {
                            Theme.get(id: themeId).buttonColor.backgroundColor
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                            Image(systemName: "plus")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(Theme.get(id: themeId).buttonColor.iconColor)
                        }
                    })
                } else {
                    SizedBox(height: .leastNonzeroMagnitude)
                }
            }
        case let model as ImageModel:
            getImageContentCell(imageModel: model,
                                sectionIndex: index)
                .disabled(!sectionModel.isVisible || viewModel.isInEditMode)
                .padding()
        case let model as TextModel:
            getTextView(textModel: model,
                        sectionIndex: index)
                .disabled(!sectionModel.isVisible || viewModel.isInEditMode)
                .padding()
        case let model as SleepSchelduleModel:
            getSleepScheduleText(model: model)
                .disabled(!sectionModel.isVisible || viewModel.isInEditMode)
                .padding()
                .onTapGesture {
                    viewModel.trigger(.onOpenCustomizeSectionDialog(model: sectionModel))
                    viewModel.trigger(.handleTimeDialog(status: .open))
                }
        default:
            Text("wait")
        }
    }
    
    // MARK: - Section dismiss button
    @ViewBuilder
    func sectionDismissButton(at sectionModel: SectionModel,
                              onTap: @escaping VoidFunction) -> some View {
        if viewModel.isInEditMode && sectionModel.isEditable {
            Button(action: onTap) {
                Image(systemName: sectionModel.isVisible ? "xmark.circle.fill" : "plus.circle.fill")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
            }
        } else {
            EmptyView()
        }
    }
    
    // MARK: - Calculate section cell
    func getSectionCell(sectionModel: SectionModel, at index: Int) -> some View {
        Section(header: SizedBox(height: index == 0 ? 50 : .leastNonzeroMagnitude)) {
            ZStack(alignment: .topLeading) {
                sectionModel.isVisible ? Theme.get(id: themeId).tableViewColor.cellBackground : Color.gray.opacity(0.5)
                VStack(alignment: .leading) {
                    HStack {
                        Text(sectionModel.title)
                            .foregroundColor(Theme.get(id: themeId).tableViewColor.text)
                        Spacer()
                        sectionDismissButton(at: sectionModel) {
                            viewModel.trigger(.onSectionVisibilityChanged(section: sectionModel.section))
                        }
                    }
                    .padding(.all, 10)
                    
                    getSectionContent(at: sectionModel, index: index)
                }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
    
    // MARK: - Done Button
    var doneButton: some View {
        Button(action: {
            viewModel.trigger(.finishThisDiary)
            onClose()
        }, label: {
            ZStack {
                Theme.get(id: themeId).buttonColor.backgroundColor
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .scaleEffect(1.1)
                Text("Done")
                    .foregroundColor(Theme.get(id: themeId).buttonColor.iconColor)
                    .padding()
            }
        })
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
    // MARK: - Navigation Bar
    var navigationBar: some View {
        HStack {
            Button(action: {
                isFocus = false
                viewModel.trigger(.editButtonTapped)
            }, label: {
                HStack {
                    Text( viewModel.isInEditMode ? "Done" : "Edit")
                        .font(.system(size: 20))
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20, alignment: .center)
                }
            })
            Spacer()
            if !viewModel.isInEditMode {
                Button(action: {
                    isFocus = false
                    viewModel.trigger(.handleResetDialog(status: .open))
                }, label: {
                    Image(systemName: "arrow.triangle.2.circlepath.circle")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 30, height: 30, alignment: .center)
                })
                
                SizedBox(width: 10)
                
                Button(action: {
                    isFocus = false
                    viewModel.trigger(.handleDismissDialog(status: .open))
                }, label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 30, height: 30, alignment: .center)
                })
            }
        }
        .foregroundColor(viewModel.state.isInLoadingMode ?
                         Color.gray :
                            Theme.get(id: themeId).navigationColor.button)
    }
    
    // MARK: - gradient
    func buildGradient() -> some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Theme.get(id: themeId).buttonColor.backgroundColor,
                                                           Color.clear]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea(.all, edges: .top)
                navigationBar
                    .padding(.horizontal, 20)
            }
            .frame(height: 80)
            Spacer()
        }
    }
    
    func buildAutoScrollButton() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                HStack(spacing: 59) {
                    ArrowAnimation(foregroundColor: Theme.get(id: themeId).buttonColor.backgroundColor)
                        .rotationEffect(Angle(degrees: 180))
                        .onTapGesture {
                            destination = .top
                        }
                    ArrowAnimation(foregroundColor: Theme.get(id: themeId).buttonColor.backgroundColor)
                        .onTapGesture {
                            destination = .bottom
                        }
                }
                .rotationEffect(Angle(degrees: 90), anchor: .topTrailing)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }
        }
    }
    
    func buildNormalView() -> some View {
        ScrollViewReader { proxy in
            List {
                ForEach(Array(viewModel.sectionModels.enumerated()),
                        id: \.offset) { index, section in
                    if section.isVisible || viewModel.isInEditMode {
                        getSectionCell(sectionModel: section,
                                       at: index)
                            .animation(.easeInOut(duration: 0.2),
                                       value: section.isVisible)
                            .id(section.section)
                    }
                }
                
                if !viewModel.isInEditMode {
                    Section(header: SizedBox(height: .leastNonzeroMagnitude),
                            footer: SizedBox(height: 200)) {
                        doneButton
                            .id("DoneButton")
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            .animation(.easeInOut(duration: 0.2), value: viewModel.state.sectionModels)
            .onChange(of: destination) { destination in
                guard let destination = destination else {
                    return
                }
                
                withAnimation(.easeInOut(duration: 0.5)) {
                    switch destination {
                    case .top:
                        proxy.scrollTo(SectionType.emotion, anchor: .top)
                    case .bottom:
                        if viewModel.isInEditMode {
                            guard let section = viewModel.state.sectionModels.last?.section else { return }
                            proxy.scrollTo(section, anchor: .bottom)
                        } else {
                            proxy.scrollTo("DoneButton", anchor: .bottom)
                        }
                    }
                }
                self.destination = nil
            }
        }
    }
    
    func buildLoadingView() -> some View {
        ZStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Theme.get(id: themeId).buttonColor.backgroundColor))
        }
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Theme.get(id: themeId).tableViewColor.background
            
            if viewModel.state.isInLoadingMode {
                buildLoadingView()
            } else {
                buildNormalView()
            }
            
            buildGradient()
            
            buildAutoScrollButton()
        }
        .onTapGesture {
            isFocus = false
        }
        .customDialog(isShowing: viewModel.state.isAboutToDismiss,
                      dialogContent: {
            DismissDialog(save: {
                viewModel.trigger(.handleDismissDialog(status: .close))
                viewModel.trigger(.finishThisDiary)
                onClose()
            }, cancel: {
                viewModel.trigger(.handleDismissDialog(status: .close))
            }, exit: {
                viewModel.trigger(.handleDismissDialog(status: .close))
                onClose()
            }).padding()
        })
        .customDialog(isShowing: viewModel.state.isAboutToReset,
                      dialogContent: {
            ResetDialog(reset: {
                viewModel.trigger(.resetAllData)
                text = ""
                viewModel.trigger(.handleResetDialog(status: .close))
            }, cancel: {
                viewModel.trigger(.handleResetDialog(status: .close))
            })
                .padding()
        })
        .customDialog(isShowing: viewModel.state.isAboutToCustomizeSection,
                      padding: 20,
                      dialogContent: {
            if let sectionModel = viewModel.state.selectedSectionModel {
                OptionAdditionView(sectionModel: sectionModel,
                                   onConfirm: { models in
                    viewModel.trigger(.handleCustomDialog(status: .close))
                    viewModel.trigger(.onCustomSection(models: models))
                    viewModel.trigger(.onOpenCustomizeSectionDialog(model: nil))
                },
                                   onCancel: {
                    viewModel.trigger(.handleCustomDialog(status: .close))
                    viewModel.trigger(.onOpenCustomizeSectionDialog(model: nil))
                })
            }
        })
        .customDialog(isShowing: viewModel.state.isAboutToShowTimePicker,
                      padding: 20,
                      dialogContent: {
            if let sleepModel = viewModel.state.selectedSectionModel?.cell as? SleepSchelduleModel {
                ClockAnimationView(sleepSchelduleModel: sleepModel,
                                   onCancel: {
                    viewModel.trigger(.handleTimeDialog(status: .close))
                },
                                   onCallback: { bedTime, wakeUpTime in
                    viewModel.trigger(.handleTimeDialog(status: .close))
                    viewModel.trigger(.onSleepScheduleChange(bedTime: bedTime, wakeUpTime: wakeUpTime))
                    viewModel.trigger(.onOpenCustomizeSectionDialog(model: nil))
                })
            }
        })
        .animation(.easeInOut(duration: 0.2), value: viewModel.diaryViewState)
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                imagePickerController = UIImagePickerController()
                viewModel.trigger(.initialSectionModels)
            })
        }
    }
}
