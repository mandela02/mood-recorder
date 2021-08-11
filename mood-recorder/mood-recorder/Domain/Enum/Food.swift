//
//  Food.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//

import Foundation

enum Food: Int, CaseIterable {
    case alcohol
    case apple
    case avocado
    case bacon
    case banana
    case bbq
    case beer
    case blueberry
    case boiledEgg
    case bread
    case butter
    case cake
    case carrot
    case celery
    case cheese
    case chicken
    case chocolate
    case cocktail
    case coffeeCup
    case corn
    case croissant
    case cucumber
    case cutlet
    case dumpling
    case eggplant
    case eggs
    case fish
    case frenchFries
    case grape
    case ham
    case honey
    case hotdog
    case iceCream
    case jam
    case juice
    case kebab
    case kiwi
    case lemon
    case lettuce
    case milk
    case milkshake
    case muffin
    case mushroom
    case nuts
    case octopus
    case omelette
    case orange
    case pancake
    case peanutButter
    case peas
    case pepper
    case pillowBread
    case pineapple
    case pizza
    case pork
    case poultry
    case pumpkin
    case rice
    case roastChicken
    case salad
    case salmon
    case sandwich
    case sausage
    case shrimp
    case smoothie
    case soup
    case spagetti
    case squid
    case strawberry
    case steak
    case sushi
    case sushiFish
    case sushiRoll
    case taco
    case tea
    case tomato
    case yogurt
    case wine
    
    var option: ImageAndTitleModel {
        switch self {
        case .alcohol:
            return ImageAndTitleModel(image: AppImage.alcohol,
                                      title: "Alcohol")
        case .apple:
            return ImageAndTitleModel(image: AppImage.apple,
                                      title: "Apple")
        case .avocado:
            return ImageAndTitleModel(image: AppImage.avocado,
                                      title: "Avocado")
        case .bacon:
            return ImageAndTitleModel(image: AppImage.bacon,
                                      title: "Bacon")
        case .banana:
            return ImageAndTitleModel(image: AppImage.banana,
                                      title: "Banana")
        case .bbq:
            return ImageAndTitleModel(image: AppImage.bbq,
                                      title: "BBQ")
        case .beer:
            return ImageAndTitleModel(image: AppImage.beer,
                                      title: "Beer")
        case .blueberry:
            return ImageAndTitleModel(image: AppImage.blueberry,
                                      title: "Blueberry")
        case .boiledEgg:
            return ImageAndTitleModel(image: AppImage.boiledEgg,
                                      title: "Boiled Egg")
        case .bread:
            return ImageAndTitleModel(image: AppImage.breadOvan,
                                      title: "Ovan Bread")
        case .butter:
            return ImageAndTitleModel(image: AppImage.butter,
                                      title: "Butter")
        case .cake:
            return ImageAndTitleModel(image: AppImage.cake,
                                      title: "Cake")
        case .carrot:
            return ImageAndTitleModel(image: AppImage.carrot,
                                      title: "Carrot")
        case .celery:
            return ImageAndTitleModel(image: AppImage.celery,
                                      title: "Celery")
        case .cheese:
            return ImageAndTitleModel(image: AppImage.cheese,
                                      title: "Cheese")
        case .chicken:
            return ImageAndTitleModel(image: AppImage.chicken,
                                      title: "Chicken")
        case .chocolate:
            return ImageAndTitleModel(image: AppImage.chocolateBar,
                                      title: "Chocolate Bar")
        case .cocktail:
            return ImageAndTitleModel(image: AppImage.cocktail,
                                      title: "Cocktail")
        case .coffeeCup:
            return ImageAndTitleModel(image: AppImage.coffeeCup,
                                      title: "Coffee")
        case .corn:
            return ImageAndTitleModel(image: AppImage.corn,
                                      title: "Corn")
        case .croissant:
            return ImageAndTitleModel(image: AppImage.croissant,
                                      title: "Croissant")
        case .cucumber:
            return ImageAndTitleModel(image: AppImage.cucumber,
                                      title: "Cucumber")
        case .cutlet:
            return ImageAndTitleModel(image: AppImage.cutlet,
                                      title: "Cutlet")
        case .dumpling:
            return ImageAndTitleModel(image: AppImage.dumpling,
                                      title: "Dumpling")
        case .eggplant:
            return ImageAndTitleModel(image: AppImage.eggplant,
                                      title: "Eggplant")
        case .eggs:
            return ImageAndTitleModel(image: AppImage.eggs,
                                      title: "Eggs")
        case .fish:
            return ImageAndTitleModel(image: AppImage.fish,
                                      title: "Fish")
        case .frenchFries:
            return ImageAndTitleModel(image: AppImage.frenchFries,
                                      title: "French Fries")
        case .grape:
            return ImageAndTitleModel(image: AppImage.grape,
                                      title: "Grape")
        case .ham:
            return ImageAndTitleModel(image: AppImage.ham,
                                      title: "Ham")
        case .honey:
            return ImageAndTitleModel(image: AppImage.honey,
                                      title: "Honey")
        case .hotdog:
            return ImageAndTitleModel(image: AppImage.hotDog,
                                      title: "Hotdog")
        case .iceCream:
            return ImageAndTitleModel(image: AppImage.iceCream,
                                      title: "Ice Cream")
        case .jam:
            return ImageAndTitleModel(image: AppImage.jam,
                                      title: "Jam")
        case .juice:
            return ImageAndTitleModel(image: AppImage.juice,
                                      title: "Juice")
        case .kebab:
            return ImageAndTitleModel(image: AppImage.kebab,
                                      title: "Kebab")
        case .kiwi:
            return ImageAndTitleModel(image: AppImage.kiwi,
                                      title: "Kiwi")
        case .lemon:
            return ImageAndTitleModel(image: AppImage.lemon,
                                      title: "Lemon")
        case .lettuce:
            return ImageAndTitleModel(image: AppImage.lettuce,
                                      title: "Lettuce")
        case .milk:
            return ImageAndTitleModel(image: AppImage.milk,
                                      title: "Milk")
        case .milkshake:
            return ImageAndTitleModel(image: AppImage.milkshake,
                                      title: "Milkshake")
        case .muffin:
            return ImageAndTitleModel(image: AppImage.muffins,
                                      title: "Muffin")
        case .mushroom:
            return ImageAndTitleModel(image: AppImage.mushroom,
                                      title: "Mushroom")
        case .nuts:
            return ImageAndTitleModel(image: AppImage.nuts,
                                      title: "Nuts")
        case .octopus:
            return ImageAndTitleModel(image: AppImage.octupus,
                                      title: "Octopus")
        case .omelette:
            return ImageAndTitleModel(image: AppImage.omelette,
                                      title: "Omelette")
        case .orange:
            return ImageAndTitleModel(image: AppImage.orange,
                                      title: "Orange")
        case .pancake:
            return ImageAndTitleModel(image: AppImage.pancake,
                                      title: "Pancake")
        case .peanutButter:
            return ImageAndTitleModel(image: AppImage.peanutButter,
                                      title: "Peanut Butter")
        case .peas:
            return ImageAndTitleModel(image: AppImage.peas,
                                      title: "Peas")
        case .pepper:
            return ImageAndTitleModel(image: AppImage.pepper,
                                      title: "Pepper")
        case .pillowBread:
            return ImageAndTitleModel(image: AppImage.pillowBread,
                                      title: "Pillow Bread")
        case .pineapple:
            return ImageAndTitleModel(image: AppImage.pineapple,
                                      title: "Pineapple")
        case .pizza:
            return ImageAndTitleModel(image: AppImage.pizza,
                                      title: "Pizza")
        case .pork:
            return ImageAndTitleModel(image: AppImage.pork,
                                      title: "Pork")
        case .poultry:
            return ImageAndTitleModel(image: AppImage.poultry,
                                      title: "Poultry")
        case .pumpkin:
            return ImageAndTitleModel(image: AppImage.pumpkin,
                                      title: "Pumpkin")
        case .rice:
            return ImageAndTitleModel(image: AppImage.rice,
                                      title: "Rice")
        case .roastChicken:
            return ImageAndTitleModel(image: AppImage.roastChicken,
                                      title: "Roast Chicken")
        case .salad:
            return ImageAndTitleModel(image: AppImage.salad,
                                      title: "Salad")
        case .salmon:
            return ImageAndTitleModel(image: AppImage.salmon,
                                      title: "Salmon")
        case .sandwich:
            return ImageAndTitleModel(image: AppImage.sandwich,
                                      title: "Sandwich")
        case .sausage:
            return ImageAndTitleModel(image: AppImage.sausage,
                                      title: "Sausage")
        case .shrimp:
            return ImageAndTitleModel(image: AppImage.shrimp,
                                      title: "Shrimp")
        case .smoothie:
            return ImageAndTitleModel(image: AppImage.smoothie,
                                      title: "Smoothie")
        case .soup:
            return ImageAndTitleModel(image: AppImage.soup,
                                      title: "Soup")
        case .spagetti:
            return ImageAndTitleModel(image: AppImage.spagetti,
                                      title: "Spagetti")
        case .squid:
            return ImageAndTitleModel(image: AppImage.squid,
                                      title: "Squid")
        case .strawberry:
            return ImageAndTitleModel(image: AppImage.strawberry,
                                      title: "Strawberry")
        case .steak:
            return ImageAndTitleModel(image: AppImage.steak,
                                      title: "Steak")
        case .sushi:
            return ImageAndTitleModel(image: AppImage.sushi,
                                      title: "sushi")
        case .sushiFish:
            return ImageAndTitleModel(image: AppImage.sushiFish,
                                      title: "Sushi Fish")
        case .sushiRoll:
            return ImageAndTitleModel(image: AppImage.sushuRoll,
                                      title: "Sushi Roll")
        case .taco:
            return ImageAndTitleModel(image: AppImage.taco,
                                      title: "Taco")
        case .tea:
            return ImageAndTitleModel(image: AppImage.tea,
                                      title: "Tea")
        case .tomato:
            return ImageAndTitleModel(image: AppImage.tomato,
                                      title: "Tomato")
        case .yogurt:
            return ImageAndTitleModel(image: AppImage.yogurt,
                                      title: "Yogurt")
        case .wine:
            return ImageAndTitleModel(image: AppImage.wine,
                                      title: "Wine")
        }
    }
    
    static var defaultOptions: [Food] {
        return [.apple, .rice, .roastChicken, .wine, shrimp, .sushi, .yogurt, .bbq, .beer, .bacon, .fish, .croissant, .dumpling, .cucumber, .taco]
    }
}
