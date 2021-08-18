//
//  AppImage+Extension.swift
//  AppImage+Extension
//
//  Created by LanNTH on 15/08/2021.
//

import Foundation

protocol StringValueProtocol {
    var value: String { get }
}

extension AppImage: StringValueProtocol {
    var value: String {
        switch self {
        case .bodyOil: return "body.oil"
        case .bra: return "bra"
        case .brush1: return "brush.1"
        case .brush2: return "brush.2"
        case .brush: return "brush"
        case .candle: return "candle"
        case .comb1: return "comb.1"
        case .comb: return "comb"
        case .corset: return "corset"
        case .cream: return "cream"
        case .dress2: return "dress.2"
        case .dressingTable: return "dressing.table"
        case .dryer: return "dryer"
        case .dye: return "dye"
        case .earing: return "earing"
        case .eyeShadow: return "eye.shadow"
        case .eyeShadows: return "eye.shadows"
        case .facialMask: return "facial.mask"
        case .fragance: return "fragance"
        case .hairBrush: return "hair.brush"
        case .hairIron: return "hair.iron"
        case .hairSalon: return "hair.salon"
        case .handMirror: return "hand.mirror"
        case .handbag: return "handbag"
        case .lips: return "lips"
        case .lipstick: return "lipstick"
        case .lotion: return "lotion"
        case .lotus: return "lotus"
        case .mascara1: return "mascara.1"
        case .mascara: return "mascara"
        case .mirror1: return "mirror.1"
        case .mirror: return "mirror"
        case .nail: return "nail"
        case .nailPolish1: return "nail.polish.1"
        case .nailPolish: return "nail.polish"
        case .nail1: return "nail1"
        case .necklace1: return "necklace.1"
        case .panties: return "panties"
        case .powder: return "powder"
        case .rollOn: return "roll.on"
        case .serum: return "serum"
        case .shampoo: return "shampoo"
        case .soapBeauty: return "soap.beauty"
        case .spa: return "spa"
        case .spray: return "spray"
        case .sunCream: return "sun.cream"
        case .tint: return "tint"
        case .tissues: return "tissues"
        case .weighLoss: return "weigh.loss"
        case .woman: return "woman"
        case .basket1: return "basket.1"
        case .basket: return "basket"
        case .bottle1: return "bottle.1"
        case .bottle2: return "bottle.2"
        case .bottle3: return "bottle.3"
        case .bottle4: return "bottle.4"
        case .bottle5: return "bottle.5"
        case .bottle6: return "bottle.6"
        case .bottle7: return "bottle.7"
        case .broom1: return "broom.1"
        case .broom2: return "broom.2"
        case .bubbles2: return "bubbles.2"
        case .bucket: return "bucket"
        case .bucket1: return "bucket1"
        case .bucket2: return "bucket2"
        case .detergent: return "detergent"
        case .dishWashing1: return "dish.washing.1"
        case .houseCleaning: return "house.cleaning"
        case .paperTowel: return "paper.towel"
        case .rake: return "rake"
        case .rubbishBin1: return "rubbish.bin.1"
        case .rubbishBin2: return "rubbish.bin.2"
        case .rubbishBin3: return "rubbish.bin.3"
        case .rubbishBin: return "rubbish.bin"
        case .sink: return "sink"
        case .soap1: return "soap.1"
        case .soap2: return "soap.2"
        case .soap3: return "soap.3"
        case .softener: return "softener"
        case .spray1: return "spray.1"
        case .spray2: return "spray.2"
        case .wash: return "wash"
        case .washingMachine: return "washing.machine"
        case .washingUp: return "washing.up"
        case .wc: return "wc"
        case .wetFloor: return "wet.floor"
        case .wheel: return "wheel"
        case .windowCleaning1: return "window.cleaning.1"
        case .windowCleaning2: return "window.cleaning.2"
        case .bubbles1: return "bubbles.1"
        case .angelDino: return "angel.dino"
        case .angry: return "angry"
        case .angryRawr: return "angry.rawr"
        case .artist: return "artist"
        case .beauty: return "beauty"
        case .beauty1: return "beauty1"
        case .beauty2: return "beauty2"
        case .birthday: return "birthday"
        case .boxing: return "boxing"
        case .chefDino: return "chef.dino"
        case .coolDino: return "cool.dino"
        case .costume: return "costume"
        case .dancingDino: return "dancing.dino"
        case .devilDino: return "devil.dino"
        case .dinoCrying: return "dino.crying"
        case .dinoInlove: return "dino.in.love"
        case .dinoShower: return "dino.shower"
        case .dizzy: return "dizzy"
        case .doctorDino: return "doctor.dino"
        case .drawingDino: return "drawing.dino"
        case .drink: return "drink"
        case .drunkDino: return "drunk.dino"
        case .eat: return "eat"
        case .embarrassed: return "embarrassed"
        case .exerciseDino: return "exercise.dino"
        case .fear: return "fear"
        case .ghostDino: return "ghost.dino"
        case .happyDino: return "happy.dino"
        case .ideaDino: return "idea.dino"
        case .kiss: return "kiss"
        case .laughingDino: return "laughing.dino"
        case .movie: return "movie"
        case .music: return "music"
        case .painter: return "painter"
        case .phoneCall: return "phone.call"
        case .photographer: return "photographer"
        case .readingDino: return "reading.dino"
        case .scientist: return "scientist"
        case .selfieDino: return "selfie.dino"
        case .sickDino: return "sick.dino"
        case .sing: return "sing"
        case .sleepyDino: return "sleepy.dino"
        case .space: return "space"
        case .stanClaus: return "stan.claus"
        case .surprise: return "surprise"
        case .swim: return "swim"
        case .thief: return "thief"
        case .think: return "think"
        case .warm: return "warm"
        case .workerDino: return "worker.dino"
        case .alarmClock: return "alarm.clock"
        case .atom: return "atom"
        case .backpack: return "backpack"
        case .binder: return "binder"
        case .blackboard: return "blackboard"
        case .books: return "books"
        case .briefcase: return "briefcase"
        case .calculator: return "calculator"
        case .colorPalette: return "color.palette"
        case .compass: return "compass"
        case .deskChair: return "desk.chair"
        case .desk: return "desk"
        case .deskLamp: return "desk.lamp"
        case .dictionary: return "dictionary"
        case .diploma: return "diploma"
        case .dna: return "dna"
        case .easel: return "easel"
        case .examFail: return "exam.fail"
        case .exam: return "exam"
        case .field: return "field"
        case .flask: return "flask"
        case .flute: return "flute"
        case .folder: return "folder"
        case .fountainPen: return "fountain.pen"
        case .geography: return "geography"
        case .glasses: return "glasses"
        case .hightlighter: return "hightlighter"
        case .laptop: return "laptop"
        case .lockers: return "lockers"
        case .medal: return "medal"
        case .microscopeStudy: return "microscope.study"
        case .mortarboard: return "mortarboard"
        case .notebook: return "notebook"
        case .notebookOpen: return "notebook.open"
        case .paperPlane: return "paper.plane"
        case .pen: return "pen"
        case .pencilCase2: return "pencil.case.2"
        case .pencilCase: return "pencil.case"
        case .ruler: return "ruler"
        case .schoolBus: return "school.bus"
        case .school: return "school"
        case .sculpture: return "sculpture"
        case .solarSystem: return "solar.system"
        case .studentCard: return "student.card"
        case .telescope: return "telescope"
        case .testing: return "testing"
        case .timeTable: return "time.table"
        case .trophy: return "trophy"
        case .whistle: return "whistle"
        case .whiteboard: return "whiteboard"
        case .airhorn: return "airhorn"
        case .auditorium: return "auditorium"
        case .balloons: return "balloons"
        case .banner: return "banner"
        case .beach: return "beach"
        case .cakeParty: return "cake.party"
        case .candy: return "candy"
        case .champagne: return "champagne"
        case .clown: return "clown"
        case .confetti: return "confetti"
        case .cupcake: return "cupcake"
        case .cups: return "cups"
        case .date: return "date"
        case .dinnerTable: return "dinner.table"
        case .discoBall: return "disco.ball"
        case .dress: return "dress"
        case .eventHall: return "event.hall"
        case .eyeMask: return "eye.mask"
        case .fireworks: return "fireworks"
        case .garlands: return "garlands"
        case .giftBox: return "gift.box"
        case .gong: return "gong"
        case .highHeels: return "high.heels"
        case .host: return "host"
        case .icCard: return "ic.card"
        case .invitation: return "invitation"
        case .kazoo: return "kazoo"
        case .location: return "location"
        case .magicShow: return "magic.show"
        case .microphone: return "microphone"
        case .openingCeremony: return "opening.ceremony"
        case .partyBlower: return "party.blower"
        case .partyHat: return "party.hat"
        case .photoBooth: return "photo.booth"
        case .photoCamera: return "photo.camera"
        case .pinata: return "pinata"
        case .pizzaParty: return "pizza.party"
        case .poolParty: return "pool.party"
        case .redCarpet: return "red.carpet"
        case .saxophone: return "saxophone"
        case .skewer: return "skewer"
        case .speaker: return "speaker"
        case .stage: return "stage"
        case .suit: return "suit"
        case .theater: return "theater"
        case .ticket: return "ticket"
        case .videoCamera: return "video.camera"
        case .vinylPlayer: return "vinyl.player"
        case .waiter: return "waiter"
        case .weddingArch: return "wedding.arch"
        case .alcohol: return "alcohol"
        case .apple: return "apple"
        case .avocado: return "avocado"
        case .bacon: return "bacon"
        case .banana: return "banana"
        case .bbq: return "bbq"
        case .beer: return "beer"
        case .blueberry: return "blueberry"
        case .boiledEgg: return "boiled.egg"
        case .breadOvan: return "bread.ovan"
        case .breakfast: return "breakfast"
        case .butter: return "butter"
        case .cake: return "cake"
        case .carrot: return "carrot"
        case .casserole: return "casserole"
        case .celery: return "celery"
        case .cheese: return "cheese"
        case .chicken: return "chicken"
        case .chocolateBar: return "chocolate.bar"
        case .cocktail: return "cocktail"
        case .coffeeCup: return "coffee.cup"
        case .corn: return "corn"
        case .croissant: return "croissant"
        case .cucumber: return "cucumber"
        case .cutlery: return "cutlery"
        case .cutlet: return "cutlet"
        case .dessert: return "dessert"
        case .doughRollingaction: return "dough.rolling.action"
        case .dumpling: return "dumpling"
        case .eggplant: return "eggplant"
        case .eggs: return "eggs"
        case .fastFood: return "fast.food"
        case .fish: return "fish"
        case .flour: return "flour"
        case .frenchFries: return "french.fries"
        case .garlic: return "garlic"
        case .glutenFree: return "gluten.free"
        case .grape: return "grape"
        case .groceries: return "groceries"
        case .ham: return "ham"
        case .healtyFood: return "healty.food"
        case .honey: return "honey"
        case .hotDog: return "hot.dog"
        case .iceCream: return "ice.cream"
        case .jam: return "jam"
        case .juice: return "juice"
        case .kebab: return "kebab"
        case .kiwi: return "kiwi"
        case .lemon: return "lemon"
        case .lettuce: return "lettuce"
        case .milk: return "milk"
        case .milkshake: return "milkshake"
        case .muffins: return "muffins"
        case .mushroom: return "mushroom"
        case .nuts: return "nuts"
        case .octupus: return "octupus"
        case .oliveOil: return "olive.oil"
        case .omelette: return "omelette"
        case .orange: return "orange"
        case .pancake: return "pancake"
        case .peanutButter: return "peanut.butter"
        case .peas: return "peas"
        case .pepper: return "pepper"
        case .pieceOfcake: return "piece.of.cake"
        case .pillowBread: return "pillow.bread"
        case .pineapple: return "pineapple"
        case .pizza: return "pizza"
        case .pizzaSlice: return "pizza.slice"
        case .plate: return "plate"
        case .pork: return "pork"
        case .porridge: return "porridge"
        case .poultry: return "poultry"
        case .pumpkin: return "pumpkin"
        case .rice: return "rice"
        case .roastChicken: return "roast.chicken"
        case .saladDisk: return "salad.disk"
        case .salad: return "salad"
        case .salmon: return "salmon"
        case .saltAndpepper: return "salt.and.pepper"
        case .sandwich: return "sandwich"
        case .sauce: return "sauce"
        case .sausage: return "sausage"
        case .shrimp: return "shrimp"
        case .smoothie: return "smoothie"
        case .soup: return "soup"
        case .spagetti: return "spagetti"
        case .squid: return "squid"
        case .steak: return "steak"
        case .strawberry: return "strawberry"
        case .sushiFish: return "sushi.fish"
        case .sushi: return "sushi"
        case .sushuRoll: return "sushu.roll"
        case .taco: return "taco"
        case .tea: return "tea"
        case .tomato: return "tomato"
        case .tray: return "tray"
        case .vegetable: return "vegetable"
        case .waterBottle: return "water.bottle"
        case .wine: return "wine"
        case .yogurt: return "yogurt"
        case .actionCamera: return "action.camera"
        case .baking: return "baking"
        case .barbecue: return "barbecue"
        case .basketball: return "basketball"
        case .bonsai: return "bonsai"
        case .bowling: return "bowling"
        case .buildingPlan: return "building.plan"
        case .cactus: return "cactus"
        case .chatChit: return "chat.chit"
        case .chess: return "chess"
        case .cinema: return "cinema"
        case .coffeeHobby: return "coffee.hobby"
        case .controller: return "controller"
        case .cookingPod: return "cooking.pod"
        case .domino: return "domino"
        case .doughRolling: return "dough.rolling"
        case .exercise: return "exercise"
        case .facialMaskhobby: return "facial.mask.hobby"
        case .fishing: return "fishing"
        case .gardening: return "gardening"
        case .guitar: return "guitar"
        case .headphone: return "headphone"
        case .instantCamera: return "instant.camera"
        case .jogging: return "jogging"
        case .karaoke: return "karaoke"
        case .kayak: return "kayak"
        case .laptopAndbook: return "laptop.and.book"
        case .newspaper: return "newspaper"
        case .origami: return "origami"
        case .petCare: return "pet.care"
        case .piano: return "piano"
        case .pingPong: return "ping.pong"
        case .plant: return "plant"
        case .playingCard: return "playing.card"
        case .postStamp: return "post.stamp"
        case .readingBook: return "reading.book"
        case .sewing: return "sewing"
        case .shopping: return "shopping"
        case .skateboard: return "skateboard"
        case .smartphonePlay: return "smartphone.play"
        case .soccerBall: return "soccer.ball"
        case .socialCamera: return "social.camera"
        case .surfboard: return "surfboard"
        case .swimming: return "swimming"
        case .teaHobby: return "tea.hobby"
        case .telescopeHobby: return "telescope.hobby"
        case .tvScreen: return "tv.screen"
        case .vrGlasses: return "vr.glasses"
        case .worker: return "worker"
        case .yoga: return "yoga"
        case .accesibility: return "accesibility"
        case .accomodation: return "accomodation"
        case .accountant: return "accountant"
        case .ads: return "ads"
        case .assignment: return "assignment"
        case .b2b: return "b2b"
        case .blogger: return "blogger"
        case .brief: return "brief"
        case .budget: return "budget"
        case .business: return "business"
        case .cashFlow: return "cash.flow"
        case .coding: return "coding"
        case .coffeeJobs: return "coffee.jobs"
        case .consultant: return "consultant"
        case .content: return "content"
        case .contentWriting: return "content.writing"
        case .customer: return "customer"
        case .designer: return "designer"
        case .digitalNomad: return "digital.nomad"
        case .digitalNomad1: return "digital.nomad1"
        case .editor: return "editor"
        case .exchange: return "exchange"
        case .finance: return "finance"
        case .growth: return "growth"
        case .heathycare: return "heathycare"
        case .income: return "income"
        case .influencer: return "influencer"
        case .invoice: return "invoice"
        case .laundry: return "laundry"
        case .mail: return "mail"
        case .marketing: return "marketing"
        case .network: return "network"
        case .onlineShop: return "online.shop"
        case .opportunity: return "opportunity"
        case .passionate: return "passionate"
        case .passport: return "passport"
        case .pos: return "pos"
        case .productivity: return "productivity"
        case .research: return "research"
        case .sleep: return "sleep"
        case .socialMedia: return "social.media"
        case .startup: return "startup"
        case .timeManagenment: return "time.managenment"
        case .toDolist: return "to.do.list"
        case .translator: return "translator"
        case .travel: return "travel"
        case .vlog: return "vlog"
        case .vlogger: return "vlogger"
        case .webDesign: return "web.design"
        case .brokenHeart: return "broken.heart"
        case .diamondRing: return "diamond.ring"
        case .fireLove: return "fire.love"
        case .gift: return "gift"
        case .heart: return "heart"
        case .inLove: return "in.love"
        case .lesbian: return "lesbian"
        case .longDistance: return "long.distance"
        case .loveBear: return "love.bear"
        case .loveBed: return "love.bed"
        case .loveBird: return "love.bird"
        case .loveChem: return "love.chem"
        case .loveChocolate: return "love.chocolate"
        case .loveDiary: return "love.diary"
        case .loveFly: return "love.fly"
        case .loveForever: return "love.forever"
        case .loveFrame: return "love.frame"
        case .loveGay: return "love.gay"
        case .loveHouse: return "love.house"
        case .loveLetter2: return "love.letter.2"
        case .loveLetter: return "love.letter"
        case .loveNight: return "love.night"
        case .lovePhoto: return "love.photo"
        case .lovePill: return "love.pill"
        case .loveTexting: return "love.texting"
        case .loveYinyang: return "love.yin.yang"
        case .roses: return "roses"
        case .valentine: return "valentine"
        case .weddingRing: return "wedding.ring"
        case .wineGlass: return "wine.glass"
        case .bacteria: return "bacteria"
        case .bloodCells: return "blood.cells"
        case .bloodPressuregauge: return "blood.pressure.gauge"
        case .bloodTest: return "blood.test"
        case .bodyScale: return "body.scale"
        case .bones: return "bones"
        case .cervicalCancer: return "cervical.cancer"
        case .colesterol: return "colesterol"
        case .defribillator: return "defribillator"
        case .dental: return "dental"
        case .diabetes: return "diabetes"
        case .diet: return "diet"
        case .doctor: return "doctor"
        case .dumbbell: return "dumbbell"
        case .ear: return "ear"
        case .ekg: return "ekg"
        case .eyeExamination: return "eye.examination"
        case .faceMask: return "face.mask"
        case .healthInsurance: return "health.insurance"
        case .heartRate: return "heart.rate"
        case .hospital: return "hospital"
        case .kidney: return "kidney"
        case .liver: return "liver"
        case .lungs: return "lungs"
        case .medicalApp: return "medical.app"
        case .medicalAppointment: return "medical.appointment"
        case .medicalCheckup: return "medical.check.up"
        case .medicalFolder: return "medical.folder"
        case .medicalLocation: return "medical.location"
        case .medicalReport: return "medical.report"
        case .medicalReportpaper: return "medical.report.paper"
        case .medicine: return "medicine"
        case .mentalHealth: return "mental.health"
        case .microscope: return "microscope"
        case .mobilePhone: return "mobile.phone"
        case .monitor: return "monitor"
        case .noSmoking: return "no.smoking"
        case .nurse: return "nurse"
        case .phoneCallmedical: return "phone.call.medical"
        case .prescription: return "prescription"
        case .question: return "question"
        case .smartWatch: return "smart.watch"
        case .sonography: return "sonography"
        case .speechBubble: return "speech.bubble"
        case .stethoscope: return "stethoscope"
        case .urineTest: return "urine.test"
        case .vaccine: return "vaccine"
        case .virus: return "virus"
        case .waterBottleandcup: return "water.bottle.and.cup"
        case .xRays: return "x.rays"
        case .angel: return "angel"
        case .angryPineapple: return "angry.pineapple"
        case .astronaut: return "astronaut"
        case .birthdayPineapple: return "birthday.pineapple"
        case .blushing: return "blushing"
        case .bubblesPineapple: return "bubbles.pineapple"
        case .calling: return "calling"
        case .chef: return "chef"
        case .coffee: return "coffee"
        case .confuse: return "confuse"
        case .cool: return "cool"
        case .crying: return "crying"
        case .dancing: return "dancing"
        case .detective: return "detective"
        case .devil: return "devil"
        case .drawing: return "drawing"
        case .drunk: return "drunk"
        case .eating: return "eating"
        case .exercisePineapple: return "exercise.pineapple"
        case .facial_treatment: return "facial_treatment"
        case .ghost: return "ghost"
        case .happy: return "happy"
        case .hot: return "hot"
        case .idea: return "idea"
        case .laptopPineapple: return "laptop.pineapple"
        case .laughing: return "laughing"
        case .listening: return "listening"
        case .love: return "love"
        case .pirate: return "pirate"
        case .popsicle: return "popsicle"
        case .reading: return "reading"
        case .sad: return "sad"
        case .scare: return "scare"
        case .scientific: return "scientific"
        case .selfie: return "selfie"
        case .shower: return "shower"
        case .sick: return "sick"
        case .singing: return "singing"
        case .sleeping: return "sleeping"
        case .strong: return "strong"
        case .sunbathing: return "sunbathing"
        case .superhero: return "superhero"
        case .surfing: return "surfing"
        case .surprised: return "surprised"
        case .thinking: return "thinking"
        case .toothbrushing: return "toothbrushing"
        case .volleyball: return "volleyball"
        case .whistlePineapple: return "whistle.pineapple"
        case .wrestler: return "wrestler"
        case .zombie: return "zombie"
        case .bigWind: return "big.wind"
        case .calendarSun: return "calendar.sun"
        case .cellphoneForecast: return "cellphone.forecast"
        case .cloudyDay: return "cloudy.day"
        case .cloudyNight: return "cloudy.night"
        case .cloudyWind: return "cloudy.wind"
        case .cold: return "cold"
        case .crescentMoon: return "crescent.moon"
        case .cyclone: return "cyclone"
        case .drop: return "drop"
        case .dropSingle: return "drop.single"
        case .earth: return "earth"
        case .earthSun: return "earth.sun"
        case .eclipse: return "eclipse"
        case .flowerFlying: return "flower.flying"
        case .flowerSingle: return "flower.single"
        case .fullMoon: return "full.moon"
        case .heavyRain: return "heavy.rain"
        case .heavySnow: return "heavy.snow"
        case .heavyStorm: return "heavy.storm"
        case .heavyThunder: return "heavy.thunder"
        case .leafFalling: return "leaf.falling"
        case .leafRedhappy: return "leaf.red.happy"
        case .mountain: return "mountain"
        case .newMoon: return "new.moon"
        case .rain: return "rain"
        case .rainNight: return "rain.night"
        case .rainbow: return "rainbow"
        case .regularRainy: return "regular.rainy"
        case .regularSnow: return "regular.snow"
        case .snow: return "snow"
        case .snowflake: return "snowflake"
        case .snowman: return "snowman"
        case .springRain: return "spring.rain"
        case .sunny: return "sunny"
        case .sweat: return "sweat"
        case .thermometerCold: return "thermometer.cold"
        case .thermometerHot: return "thermometer.hot"
        case .thermometer: return "thermometer"
        case .thunder: return "thunder"
        case .tornado: return "tornado"
        case .treeFalling: return "tree.falling"
        case .treeHappy: return "tree.happy"
        case .treeRedhappy: return "tree.red.happy"
        case .umbrellaColorful: return "umbrella.colorful"
        case .umbrella: return "umbrella"
        case .umbrellaNormal: return "umbrella.normal"
        case .waxingMoon: return "waxing.moon"
        case .wildFire: return "wild.fire"
        case .wind: return "wind"
        default: return ""
        }
    }
    
    
    static func appImage(value: String) -> AppImage {
        guard let index = allNames.firstIndex(where: {$0 == value}) else {
            return .dinoCrying
        }
        return  AppImage.allCases[index]
    }
    
    
    static let allNames = AppImage.allCases.map { $0.value }
}