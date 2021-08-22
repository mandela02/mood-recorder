//
//  Job.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//

import Foundation

enum Job: Int, CaseIterable {
    case accountant
    case ads
    case assignment
    case blogger
    case budget
    case business
    case coding
    case consultant
    case contentWriting
    case designer
    case digitalNomad
    case editor
    case exchange
    case finance
    case growth
    case heathycare
    case income
    case influencer
    case marketing
    case onlineShop
    case opportunity
    case passionate
    case research
    case startup
    case timeManagenment
    case translator
    case travel
    case vlogger
    case webDesign
    
    var option: ImageAndTitleModel {
        switch self {
        case .accountant:
            return ImageAndTitleModel(image: AppImage.accountant,
                                      title: "Accountant")
        case .ads:
            return ImageAndTitleModel(image: AppImage.ads,
                                      title: "Ads")
        case .assignment:
            return ImageAndTitleModel(image: AppImage.assignment,
                                      title: "Assignment")
        case .blogger:
            return ImageAndTitleModel(image: AppImage.blogger,
                                      title: "Blogger")
        case .budget:
            return ImageAndTitleModel(image: AppImage.budget,
                                      title: "Budget balance")
        case .business:
            return ImageAndTitleModel(image: AppImage.business,
                                      title: "Business idea")
        case .coding:
            return ImageAndTitleModel(image: AppImage.coding,
                                      title: "Coding")
        case .consultant:
            return ImageAndTitleModel(image: AppImage.consultant,
                                      title: "Consultant")
        case .contentWriting:
            return ImageAndTitleModel(image: AppImage.contentWriting,
                                      title: "Content writing")
        case .designer:
            return ImageAndTitleModel(image: AppImage.designer,
                                      title: "Designer")
        case .digitalNomad:
            return ImageAndTitleModel(image: AppImage.digitalNomad,
                                      title: "Work from home")
        case .editor:
            return ImageAndTitleModel(image: AppImage.editor,
                                      title: "Editor")
        case .exchange:
            return ImageAndTitleModel(image: AppImage.exchange,
                                      title: "Exchange")
        case .finance:
            return ImageAndTitleModel(image: AppImage.finance,
                                      title: "Finance")
        case .growth:
            return ImageAndTitleModel(image: AppImage.growth,
                                      title: "Business Growth")
        case .heathycare:
            return ImageAndTitleModel(image: AppImage.heathycare,
                                      title: "Health Care")
        case .income:
            return ImageAndTitleModel(image: AppImage.income,
                                      title: "Income")
        case .influencer:
            return ImageAndTitleModel(image: AppImage.influencer,
                                      title: "Influencer")
        case .marketing:
            return ImageAndTitleModel(image: AppImage.marketing,
                                      title: "Marketing")
        case .onlineShop:
            return ImageAndTitleModel(image: AppImage.onlineShop,
                                      title: "Digital Shop")
        case .opportunity:
            return ImageAndTitleModel(image: AppImage.opportunity,
                                      title: "Opportunity")
        case .passionate:
            return ImageAndTitleModel(image: AppImage.passionate,
                                      title: "Passionate")
        case .research:
            return ImageAndTitleModel(image: AppImage.research,
                                      title: "Research")
        case .startup:
            return ImageAndTitleModel(image: AppImage.startup,
                                      title: "Start Up")
        case .timeManagenment:
            return ImageAndTitleModel(image: AppImage.timeManagenment,
                                      title: "Time Managenment")
        case .translator:
            return ImageAndTitleModel(image: AppImage.translator,
                                      title: "translator")
        case .travel:
            return ImageAndTitleModel(image: AppImage.travel,
                                      title: "Travel")
        case .vlogger:
            return ImageAndTitleModel(image: AppImage.vlogger,
                                      title: "Vlogger")
        case .webDesign:
            return ImageAndTitleModel(image: AppImage.accountant,
                                      title: "Web Design")
        }
    }
    
    static var defaultOptions: [Job] {
        return [.webDesign, .coding, .ads, .startup, .marketing, .blogger,
                    .budget, .consultant, .digitalNomad, .travel]
    }
}
