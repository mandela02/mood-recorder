//
//  Medical.swift
//  mood-recorder
//
//  Created by LanNTH on 07/08/2021.
//

import Foundation

enum Medical {
    case bacterial
    case bloodTest
    case bone
    case cervialCancer
    case colesterol
    case dental
    case diabete
    case diet
    case ear
    case eyeExamination
    case faceMask
    case insurance
    case hospital
    case kidney
    case liver
    case lung
    case medicine
    case mentalHealth
    case urine
    case vaccine
    case corona
    case xray
    
    var option: ImageAndTitleModel {
        switch self {
        case .bacterial:
            return ImageAndTitleModel(image: AppImage.bacteria,
                                      title: "Bacterial")
        case .bloodTest:
            return ImageAndTitleModel(image: AppImage.bloodTest,
                                      title: "Blood Test")
        case .bone:
            return ImageAndTitleModel(image: AppImage.bones,
                                      title: "Bones")
        case .cervialCancer:
            return ImageAndTitleModel(image: AppImage.cervicalCancer,
                                      title: "Uterus")
        case .colesterol:
            return ImageAndTitleModel(image: AppImage.colesterol,
                                      title: "Colesterol")
        case .dental:
            return ImageAndTitleModel(image: AppImage.dental,
                                      title: "Dental")
        case .diabete:
            return ImageAndTitleModel(image: AppImage.diabetes,
                                      title: "Diabetes")
        case .diet:
            return ImageAndTitleModel(image: AppImage.diet,
                                      title: "Diet")
        case .ear:
            return ImageAndTitleModel(image: AppImage.ear,
                                      title: "Ear examination")
        case .eyeExamination:
            return ImageAndTitleModel(image: AppImage.eyeExamination,
                                      title: "Eye examination")
        case .faceMask:
            return ImageAndTitleModel(image: AppImage.faceMask,
                                      title: "Face mask")
        case .insurance:
            return ImageAndTitleModel(image: AppImage.healthInsurance,
                                      title: "Insurance")
        case .hospital:
            return ImageAndTitleModel(image: AppImage.hospital,
                                      title: "Hospital")
        case .kidney:
            return ImageAndTitleModel(image: AppImage.kidney,
                                      title: "Kidney")
        case .liver:
            return ImageAndTitleModel(image: AppImage.liver,
                                      title: "Liver")
        case .lung:
            return ImageAndTitleModel(image: AppImage.lungs,
                                      title: "Lung")
        case .medicine:
            return ImageAndTitleModel(image: AppImage.medicine,
                                      title: "Medicine")
        case .mentalHealth:
            return ImageAndTitleModel(image: AppImage.mentalHealth,
                                      title: "Mental Health")
        case .urine:
            return ImageAndTitleModel(image: AppImage.urineTest,
                                      title: "Urine Test")
        case .vaccine:
            return ImageAndTitleModel(image: AppImage.vaccine,
                                      title: "Vaccine")
        case .corona:
            return ImageAndTitleModel(image: AppImage.virus,
                                      title: "Corona Virus")
        case .xray:
            return ImageAndTitleModel(image: AppImage.xRays,
                                      title: "X Ray")
        }
    }
    
    
    static var defaultOptions: [Medical] {
        return [.bloodTest, .lung, .mentalHealth, .dental, .corona, .vaccine, .xray, .diabete]
    }
}
