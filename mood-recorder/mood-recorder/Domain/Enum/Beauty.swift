//
//  Beauty.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//

import Foundation

enum Beauty: CaseIterable {
    case bodyOil
    case bra
    case corset
    case cream
    case dye
    case earing
    case eyeShadow
    case mask
    case fragrance
    case hairSalon
    case weightLoss
    case tissues
    case sunCream
    case spray
    case spa
    case soap
    case shampoo
    case serum
    case panties
    case necklace
    case nail
    case mascara
    case lotion
    case lipstick
    
    var option: ImageAndTitleModel {
        switch self {
        case .bodyOil:
            return ImageAndTitleModel(image: AppImage.bodyOil,
                                      title: "Body Oil")
        case .bra:
            return ImageAndTitleModel(image: AppImage.bra,
                                      title: "New Bra")
        case .corset:
            return ImageAndTitleModel(image: AppImage.corset,
                                      title: "New Corset")
        case .cream:
            return ImageAndTitleModel(image: AppImage.cream,
                                      title: "Body Cream")
        case .dye:
            return ImageAndTitleModel(image: AppImage.dye,
                                      title: "New Hair Color")
        case .earing:
            return ImageAndTitleModel(image: AppImage.earing,
                                      title: "New Earing")
        case .eyeShadow:
            return ImageAndTitleModel(image: AppImage.eyeShadow,
                                      title: "Eye Shadow")
        case .mask:
            return ImageAndTitleModel(image: AppImage.facialMask,
                                      title: "Skin Care")
        case .fragrance:
            return ImageAndTitleModel(image: AppImage.fragance,
                                      title: "Perfume")
        case .hairSalon:
            return ImageAndTitleModel(image: AppImage.hairSalon,
                                      title: "New Hair")
        case .weightLoss:
            return ImageAndTitleModel(image: AppImage.weighLoss,
                                      title: "Weight Loss")
        case .tissues:
            return ImageAndTitleModel(image: AppImage.tissues,
                                          title: "Tissues")
            
        case .sunCream:
            return ImageAndTitleModel(image: AppImage.sunCream,
                                      title: "Sun Cream")
        case .spray:
            return ImageAndTitleModel(image: AppImage.spray,
                                      title: "Body Spray")
        case .spa:
            return ImageAndTitleModel(image: AppImage.spa,
                                      title: "Spa")
        case .soap:
            return ImageAndTitleModel(image: AppImage.soapBeauty,
                                      title: "Soap")
        case .shampoo:
            return ImageAndTitleModel(image: AppImage.shampoo,
                                      title: "Shampoo")
        case .serum:
            return ImageAndTitleModel(image: AppImage.serum,
                                      title: "Serum")
        case .panties:
            return ImageAndTitleModel(image: AppImage.panties,
                                      title: "New panties")
        case .necklace:
            return ImageAndTitleModel(image: AppImage.necklace1,
                                      title: "beautiful Necklace")
        case .nail:
            return ImageAndTitleModel(image: AppImage.nail,
                                      title: "Nail")
        case .mascara:
            return ImageAndTitleModel(image: AppImage.mascara1,
                                      title: "Mascara")
        case .lotion:
            return ImageAndTitleModel(image: AppImage.lotion,
                                      title: "Lotion")
        case .lipstick:
            return ImageAndTitleModel(image: AppImage.lipstick,
                                      title: "Lipstick")
        }
    }
    
    static var defaultOptions: [Beauty] {
        return [.weightLoss, .mascara, .mask, .nail, .sunCream]
    }
}
