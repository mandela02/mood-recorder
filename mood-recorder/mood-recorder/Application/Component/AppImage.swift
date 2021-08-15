//
//  AppImage.swift
//  mood-recorder
//
//  Created by LanNTH on 02/08/2021.
//

import SwiftUI

protocol StringValueProtocol {
    var value: String { get }
}

enum AppImage: String, CaseIterable, StringValueProtocol {
    var value: String {
        return self.rawValue
    }
    
    case bodyOil = "body.oil"
    case bra = "bra"
    case brush1 = "brush.1"
    case brush2 = "brush.2"
    case brush = "brush"
    case candle = "candle"
    case comb1 = "comb.1"
    case comb = "comb"
    case corset = "corset"
    case cream = "cream"
    case dress2 = "dress.2"
    case dressingTable = "dressing.table"
    case dryer = "dryer"
    case dye = "dye"
    case earing = "earing"
    case eyeShadow = "eye.shadow"
    case eyeShadows = "eye.shadows"
    case facialMask = "facial.mask"
    case fragance = "fragance"
    case hairBrush = "hair.brush"
    case hairIron = "hair.iron"
    case hairSalon = "hair.salon"
    case handMirror = "hand.mirror"
    case handbag = "handbag"
    case lips = "lips"
    case lipstick = "lipstick"
    case lotion = "lotion"
    case lotus = "lotus"
    case mascara1 = "mascara.1"
    case mascara = "mascara"
    case mirror1 = "mirror.1"
    case mirror = "mirror"
    case nail = "nail"
    case nailPolish1 = "nail.polish.1"
    case nailPolish = "nail.polish"
    case nail1 = "nail1"
    case necklace1 = "necklace.1"
    case panties = "panties"
    case powder = "powder"
    case rollOn = "roll.on"
    case serum = "serum"
    case shampoo = "shampoo"
    case soapBeauty = "soap.beauty"
    case spa = "spa"
    case spray = "spray"
    case sunCream = "sun.cream"
    case tint = "tint"
    case tissues = "tissues"
    case weighLoss = "weigh.loss"
    case woman = "woman"
    case basket1 = "basket.1"
    case basket = "basket"
    case bottle1 = "bottle.1"
    case bottle2 = "bottle.2"
    case bottle3 = "bottle.3"
    case bottle4 = "bottle.4"
    case bottle5 = "bottle.5"
    case bottle6 = "bottle.6"
    case bottle7 = "bottle.7"
    case broom1 = "broom.1"
    case broom2 = "broom.2"
    case bubbles2 = "bubbles.2"
    case bucket = "bucket"
    case bucket1 = "bucket1"
    case bucket2 = "bucket2"
    case detergent = "detergent"
    case dishWashing1 = "dish.washing.1"
    case houseCleaning = "house.cleaning"
    case paperTowel = "paper.towel"
    case rake = "rake"
    case rubbishBin1 = "rubbish.bin.1"
    case rubbishBin2 = "rubbish.bin.2"
    case rubbishBin3 = "rubbish.bin.3"
    case rubbishBin = "rubbish.bin"
    case sink = "sink"
    case soap1 = "soap.1"
    case soap2 = "soap.2"
    case soap3 = "soap.3"
    case softener = "softener"
    case spray1 = "spray.1"
    case spray2 = "spray.2"
    case wash = "wash"
    case washingMachine = "washing.machine"
    case washingUp = "washing.up"
    case wc = "wc"
    case wetFloor = "wet.floor"
    case wheel = "wheel"
    case windowCleaning1 = "window.cleaning.1"
    case windowCleaning2 = "window.cleaning.2"
    case bubbles1 = "bubbles.1"
    case angelDino = "angel.dino"
    case angry = "angry"
    case angryRawr = "angry.rawr"
    case artist = "artist"
    case beauty = "beauty"
    case beauty1 = "beauty1"
    case beauty2 = "beauty2"
    case birthday = "birthday"
    case boxing = "boxing"
    case chefDino = "chef.dino"
    case coolDino = "cool.dino"
    case costume = "costume"
    case dancingDino = "dancing.dino"
    case devilDino = "devil.dino"
    case dinoCrying = "dino.crying"
    case dinoInlove = "dino.in.love"
    case dinoShower = "dino.shower"
    case dizzy = "dizzy"
    case doctorDino = "doctor.dino"
    case drawingDino = "drawing.dino"
    case drink = "drink"
    case drunkDino = "drunk.dino"
    case eat = "eat"
    case embarrassed = "embarrassed"
    case exerciseDino = "exercise.dino"
    case fear = "fear"
    case ghostDino = "ghost.dino"
    case happyDino = "happy.dino"
    case ideaDino = "idea.dino"
    case kiss = "kiss"
    case laughingDino = "laughing.dino"
    case movie = "movie"
    case music = "music"
    case painter = "painter"
    case phoneCall = "phone.call"
    case photographer = "photographer"
    case readingDino = "reading.dino"
    case scientist = "scientist"
    case selfieDino = "selfie.dino"
    case sickDino = "sick.dino"
    case sing = "sing"
    case sleepyDino = "sleepy.dino"
    case space = "space"
    case stanClaus = "stan.claus"
    case surprise = "surprise"
    case swim = "swim"
    case thief = "thief"
    case think = "think"
    case warm = "warm"
    case workerDino = "worker.dino"
    case alarmClock = "alarm.clock"
    case atom = "atom"
    case backpack = "backpack"
    case binder = "binder"
    case blackboard = "blackboard"
    case books = "books"
    case briefcase = "briefcase"
    case calculator = "calculator"
    case colorPalette = "color.palette"
    case compass = "compass"
    case deskChair = "desk.chair"
    case desk = "desk"
    case deskLamp = "desk.lamp"
    case dictionary = "dictionary"
    case diploma = "diploma"
    case dna = "dna"
    case easel = "easel"
    case examFail = "exam.fail"
    case exam = "exam"
    case field = "field"
    case flask = "flask"
    case flute = "flute"
    case folder = "folder"
    case fountainPen = "fountain.pen"
    case geography = "geography"
    case glasses = "glasses"
    case hightlighter = "hightlighter"
    case laptop = "laptop"
    case lockers = "lockers"
    case medal = "medal"
    case microscopeStudy = "microscope.study"
    case mortarboard = "mortarboard"
    case notebook = "notebook"
    case notebookOpen = "notebook.open"
    case paperPlane = "paper.plane"
    case pen = "pen"
    case pencilCase2 = "pencil.case.2"
    case pencilCase = "pencil.case"
    case ruler = "ruler"
    case schoolBus = "school.bus"
    case school = "school"
    case sculpture = "sculpture"
    case solarSystem = "solar.system"
    case studentCard = "student.card"
    case telescope = "telescope"
    case testing = "testing"
    case timeTable = "time.table"
    case trophy = "trophy"
    case whistle = "whistle"
    case whiteboard = "whiteboard"
    case airhorn = "airhorn"
    case auditorium = "auditorium"
    case balloons = "balloons"
    case banner = "banner"
    case beach = "beach"
    case cakeParty = "cake.party"
    case candy = "candy"
    case champagne = "champagne"
    case clown = "clown"
    case confetti = "confetti"
    case cupcake = "cupcake"
    case cups = "cups"
    case date = "date"
    case dinnerTable = "dinner.table"
    case discoBall = "disco.ball"
    case dress = "dress"
    case eventHall = "event.hall"
    case eyeMask = "eye.mask"
    case fireworks = "fireworks"
    case garlands = "garlands"
    case giftBox = "gift.box"
    case gong = "gong"
    case highHeels = "high.heels"
    case host = "host"
    case icCard = "ic.card"
    case invitation = "invitation"
    case kazoo = "kazoo"
    case location = "location"
    case magicShow = "magic.show"
    case microphone = "microphone"
    case openingCeremony = "opening.ceremony"
    case partyBlower = "party.blower"
    case partyHat = "party.hat"
    case photoBooth = "photo.booth"
    case photoCamera = "photo.camera"
    case pinata = "pinata"
    case pizzaParty = "pizza.party"
    case poolParty = "pool.party"
    case redCarpet = "red.carpet"
    case saxophone = "saxophone"
    case skewer = "skewer"
    case speaker = "speaker"
    case stage = "stage"
    case suit = "suit"
    case theater = "theater"
    case ticket = "ticket"
    case videoCamera = "video.camera"
    case vinylPlayer = "vinyl.player"
    case waiter = "waiter"
    case weddingArch = "wedding.arch"
    case alcohol = "alcohol"
    case apple = "apple"
    case avocado = "avocado"
    case bacon = "bacon"
    case banana = "banana"
    case bbq = "bbq"
    case beer = "beer"
    case blueberry = "blueberry"
    case boiledEgg = "boiled.egg"
    case breadOvan = "bread.ovan"
    case breakfast = "breakfast"
    case butter = "butter"
    case cake = "cake"
    case carrot = "carrot"
    case casserole = "casserole"
    case celery = "celery"
    case cheese = "cheese"
    case chicken = "chicken"
    case chocolateBar = "chocolate.bar"
    case cocktail = "cocktail"
    case coffeeCup = "coffee.cup"
    case corn = "corn"
    case croissant = "croissant"
    case cucumber = "cucumber"
    case cutlery = "cutlery"
    case cutlet = "cutlet"
    case dessert = "dessert"
    case doughRollingaction = "dough.rolling.action"
    case dumpling = "dumpling"
    case eggplant = "eggplant"
    case eggs = "eggs"
    case fastFood = "fast.food"
    case fish = "fish"
    case flour = "flour"
    case frenchFries = "french.fries"
    case garlic = "garlic"
    case glutenFree = "gluten.free"
    case grape = "grape"
    case groceries = "groceries"
    case ham = "ham"
    case healtyFood = "healty.food"
    case honey = "honey"
    case hotDog = "hot.dog"
    case iceCream = "ice.cream"
    case jam = "jam"
    case juice = "juice"
    case kebab = "kebab"
    case kiwi = "kiwi"
    case lemon = "lemon"
    case lettuce = "lettuce"
    case milk = "milk"
    case milkshake = "milkshake"
    case muffins = "muffins"
    case mushroom = "mushroom"
    case nuts = "nuts"
    case octupus = "octupus"
    case oliveOil = "olive.oil"
    case omelette = "omelette"
    case orange = "orange"
    case pancake = "pancake"
    case peanutButter = "peanut.butter"
    case peas = "peas"
    case pepper = "pepper"
    case pieceOfcake = "piece.of.cake"
    case pillowBread = "pillow.bread"
    case pineapple = "pineapple"
    case pizza = "pizza"
    case pizzaSlice = "pizza.slice"
    case plate = "plate"
    case pork = "pork"
    case porridge = "porridge"
    case poultry = "poultry"
    case pumpkin = "pumpkin"
    case rice = "rice"
    case roastChicken = "roast.chicken"
    case saladDisk = "salad.disk"
    case salad = "salad"
    case salmon = "salmon"
    case saltAndpepper = "salt.and.pepper"
    case sandwich = "sandwich"
    case sauce = "sauce"
    case sausage = "sausage"
    case shrimp = "shrimp"
    case smoothie = "smoothie"
    case soup = "soup"
    case spagetti = "spagetti"
    case squid = "squid"
    case steak = "steak"
    case strawberry = "strawberry"
    case sushiFish = "sushi.fish"
    case sushi = "sushi"
    case sushuRoll = "sushu.roll"
    case taco = "taco"
    case tea = "tea"
    case tomato = "tomato"
    case tray = "tray"
    case vegetable = "vegetable"
    case waterBottle = "water.bottle"
    case wine = "wine"
    case yogurt = "yogurt"
    case actionCamera = "action.camera"
    case baking = "baking"
    case barbecue = "barbecue"
    case basketball = "basketball"
    case bonsai = "bonsai"
    case bowling = "bowling"
    case buildingPlan = "building.plan"
    case cactus = "cactus"
    case chatChit = "chat.chit"
    case chess = "chess"
    case cinema = "cinema"
    case coffeeHobby = "coffee.hobby"
    case controller = "controller"
    case cookingPod = "cooking.pod"
    case domino = "domino"
    case doughRolling = "dough.rolling"
    case exercise = "exercise"
    case facialMaskhobby = "facial.mask.hobby"
    case fishing = "fishing"
    case gardening = "gardening"
    case guitar = "guitar"
    case headphone = "headphone"
    case instantCamera = "instant.camera"
    case jogging = "jogging"
    case karaoke = "karaoke"
    case kayak = "kayak"
    case laptopAndbook = "laptop.and.book"
    case newspaper = "newspaper"
    case origami = "origami"
    case petCare = "pet.care"
    case piano = "piano"
    case pingPong = "ping.pong"
    case plant = "plant"
    case playingCard = "playing.card"
    case postStamp = "post.stamp"
    case readingBook = "reading.book"
    case sewing = "sewing"
    case shopping = "shopping"
    case skateboard = "skateboard"
    case smartphonePlay = "smartphone.play"
    case soccerBall = "soccer.ball"
    case socialCamera = "social.camera"
    case surfboard = "surfboard"
    case swimming = "swimming"
    case teaHobby = "tea.hobby"
    case telescopeHobby = "telescope.hobby"
    case tvScreen = "tv.screen"
    case vrGlasses = "vr.glasses"
    case worker = "worker"
    case yoga = "yoga"
    case accesibility = "accesibility"
    case accomodation = "accomodation"
    case accountant = "accountant"
    case ads = "ads"
    case assignment = "assignment"
    case b2b = "b2b"
    case blogger = "blogger"
    case brief = "brief"
    case budget = "budget"
    case business = "business"
    case cashFlow = "cash.flow"
    case coding = "coding"
    case coffeeJobs = "coffee.jobs"
    case consultant = "consultant"
    case content = "content"
    case contentWriting = "content.writing"
    case customer = "customer"
    case designer = "designer"
    case digitalNomad = "digital.nomad"
    case digitalNomad1 = "digital.nomad1"
    case editor = "editor"
    case exchange = "exchange"
    case finance = "finance"
    case growth = "growth"
    case heathycare = "heathycare"
    case income = "income"
    case influencer = "influencer"
    case invoice = "invoice"
    case laundry = "laundry"
    case mail = "mail"
    case marketing = "marketing"
    case network = "network"
    case onlineShop = "online.shop"
    case opportunity = "opportunity"
    case passionate = "passionate"
    case passport = "passport"
    case pos = "pos"
    case productivity = "productivity"
    case research = "research"
    case sleep = "sleep"
    case socialMedia = "social.media"
    case startup = "startup"
    case timeManagenment = "time.managenment"
    case toDolist = "to.do.list"
    case translator = "translator"
    case travel = "travel"
    case vlog = "vlog"
    case vlogger = "vlogger"
    case webDesign = "web.design"
    case brokenHeart = "broken.heart"
    case diamondRing = "diamond.ring"
    case fireLove = "fire.love"
    case gift = "gift"
    case heart = "heart"
    case inLove = "in.love"
    case lesbian = "lesbian"
    case longDistance = "long.distance"
    case loveBear = "love.bear"
    case loveBed = "love.bed"
    case loveBird = "love.bird"
    case loveChem = "love.chem"
    case loveChocolate = "love.chocolate"
    case loveDiary = "love.diary"
    case loveFly = "love.fly"
    case loveForever = "love.forever"
    case loveFrame = "love.frame"
    case loveGay = "love.gay"
    case loveHouse = "love.house"
    case loveLetter2 = "love.letter.2"
    case loveLetter = "love.letter"
    case loveNight = "love.night"
    case lovePhoto = "love.photo"
    case lovePill = "love.pill"
    case loveTexting = "love.texting"
    case loveYinyang = "love.yin.yang"
    case roses = "roses"
    case valentine = "valentine"
    case weddingRing = "wedding.ring"
    case wineGlass = "wine.glass"
    case bacteria = "bacteria"
    case bloodCells = "blood.cells"
    case bloodPressuregauge = "blood.pressure.gauge"
    case bloodTest = "blood.test"
    case bodyScale = "body.scale"
    case bones = "bones"
    case cervicalCancer = "cervical.cancer"
    case colesterol = "colesterol"
    case defribillator = "defribillator"
    case dental = "dental"
    case diabetes = "diabetes"
    case diet = "diet"
    case doctor = "doctor"
    case dumbbell = "dumbbell"
    case ear = "ear"
    case ekg = "ekg"
    case eyeExamination = "eye.examination"
    case faceMask = "face.mask"
    case healthInsurance = "health.insurance"
    case heartRate = "heart.rate"
    case hospital = "hospital"
    case kidney = "kidney"
    case liver = "liver"
    case lungs = "lungs"
    case medicalApp = "medical.app"
    case medicalAppointment = "medical.appointment"
    case medicalCheckup = "medical.check.up"
    case medicalFolder = "medical.folder"
    case medicalLocation = "medical.location"
    case medicalReport = "medical.report"
    case medicalReportpaper = "medical.report.paper"
    case medicine = "medicine"
    case mentalHealth = "mental.health"
    case microscope = "microscope"
    case mobilePhone = "mobile.phone"
    case monitor = "monitor"
    case noSmoking = "no.smoking"
    case nurse = "nurse"
    case phoneCallmedical = "phone.call.medical"
    case prescription = "prescription"
    case question = "question"
    case smartWatch = "smart.watch"
    case sonography = "sonography"
    case speechBubble = "speech.bubble"
    case stethoscope = "stethoscope"
    case urineTest = "urine.test"
    case vaccine = "vaccine"
    case virus = "virus"
    case waterBottleandcup = "water.bottle.and.cup"
    case xRays = "x.rays"
    case angel = "angel"
    case angryPineapple = "angry.pineapple"
    case astronaut = "astronaut"
    case birthdayPineapple = "birthday.pineapple"
    case blushing = "blushing"
    case bubblesPineapple = "bubbles.pineapple"
    case calling = "calling"
    case chef = "chef"
    case coffee = "coffee"
    case confuse = "confuse"
    case cool = "cool"
    case crying = "crying"
    case dancing = "dancing"
    case detective = "detective"
    case devil = "devil"
    case drawing = "drawing"
    case drunk = "drunk"
    case eating = "eating"
    case exercisePineapple = "exercise.pineapple"
    case facial_treatment = "facial_treatment"
    case ghost = "ghost"
    case happy = "happy"
    case hot = "hot"
    case idea = "idea"
    case laptopPineapple = "laptop.pineapple"
    case laughing = "laughing"
    case listening = "listening"
    case love = "love"
    case pirate = "pirate"
    case popsicle = "popsicle"
    case reading = "reading"
    case sad = "sad"
    case scare = "scare"
    case scientific = "scientific"
    case selfie = "selfie"
    case shower = "shower"
    case sick = "sick"
    case singing = "singing"
    case sleeping = "sleeping"
    case strong = "strong"
    case sunbathing = "sunbathing"
    case superhero = "superhero"
    case surfing = "surfing"
    case surprised = "surprised"
    case thinking = "thinking"
    case toothbrushing = "toothbrushing"
    case volleyball = "volleyball"
    case whistlePineapple = "whistle.pineapple"
    case wrestler = "wrestler"
    case zombie = "zombie"
    case bigWind = "big.wind"
    case calendarSun = "calendar.sun"
    case cellphoneForecast = "cellphone.forecast"
    case cloudyDay = "cloudy.day"
    case cloudyNight = "cloudy.night"
    case cloudyWind = "cloudy.wind"
    case cold = "cold"
    case crescentMoon = "crescent.moon"
    case cyclone = "cyclone"
    case drop = "drop"
    case dropSingle = "drop.single"
    case earth = "earth"
    case earthSun = "earth.sun"
    case eclipse = "eclipse"
    case flowerFlying = "flower.flying"
    case flowerSingle = "flower.single"
    case fullMoon = "full.moon"
    case heavyRain = "heavy.rain"
    case heavySnow = "heavy.snow"
    case heavyStorm = "heavy.storm"
    case heavyThunder = "heavy.thunder"
    case leafFalling = "leaf.falling"
    case leafRedhappy = "leaf.red.happy"
    case mountain = "mountain"
    case newMoon = "new.moon"
    case rain = "rain"
    case rainNight = "rain.night"
    case rainbow = "rainbow"
    case regularRainy = "regular.rainy"
    case regularSnow = "regular.snow"
    case snow = "snow"
    case snowflake = "snowflake"
    case snowman = "snowman"
    case springRain = "spring.rain"
    case sunny = "sunny"
    case sweat = "sweat"
    case thermometerCold = "thermometer.cold"
    case thermometerHot = "thermometer.hot"
    case thermometer = "thermometer"
    case thunder = "thunder"
    case tornado = "tornado"
    case treeFalling = "tree.falling"
    case treeHappy = "tree.happy"
    case treeRedhappy = "tree.red.happy"
    case umbrellaColorful = "umbrella.colorful"
    case umbrella = "umbrella"
    case umbrellaNormal = "umbrella.normal"
    case waxingMoon = "waxing.moon"
    case wildFire = "wild.fire"
    case wind = "wind"
}
