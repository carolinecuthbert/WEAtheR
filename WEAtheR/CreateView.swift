import SwiftUI
import CoreLocation
import SwiftData

struct CreateView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var weather: WeatherResponse?
    @StateObject private var viewModel = LocationViewModel()
    @State private var isSaved = false
    @State private var didntComplete = false
    @Bindable var tripItem: TripItem
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Spacer()
                    if (didntComplete) {
                        Text("Please fill out all fields!")
                            .italic()
                            .font(.system(size: 25))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.red)
                    }
                    Spacer()
                    HStack {
                        Text("Trip Title:")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } // HStack
                    
                    TextField("Type here...", text: $tripItem.title)
                        .font(.system(size: 25))
                        .multilineTextAlignment(.center)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(15)
                        .padding(.bottom)
                        .lineLimit(5)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    HStack {
                        Text("Location:")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } // HStack
                    
                    TextField("Type here...", text: $tripItem.location)
                        .font(.system(size: 25))
                        .multilineTextAlignment(.center)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(15)
                        .padding(.bottom)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    HStack {
                        Text("Length (days):")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } // HStack
                    
                    TextField("Type a number here...", value: $tripItem.length, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .font(.system(size: 25))
                        .multilineTextAlignment(.center)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(15)
                        .padding(.bottom)
                }
                
                .padding()
                
                Spacer()
                    .frame(height: 50)
                
                VStack {
                    Text("Occasion:")
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    HStack{
                        if (tripItem.occasion == "formal") {
                            Button("Formal") {}
                                .font(.title2)
                                .buttonStyle(.borderedProminent)
                                .foregroundStyle(Color.black)
                                .tint(Color("for"))
                                .border(Color.black, width: 4)
                        } else {
                            Button("Formal") {
                                tripItem.occasion = "formal"
                            }
                            .font(.title2)
                            .buttonStyle(.borderedProminent)
                            .foregroundStyle(Color.black)
                            .tint(Color("for"))
                        }
                        Spacer()
                            .frame(width: 20.0)
                        if (tripItem.occasion == "athletic") {
                            Button("Athletic") {}
                                .font(.title2)
                                .buttonStyle(.borderedProminent)
                                .foregroundStyle(Color.black)
                                .tint(Color("ath"))
                                .border(Color.black, width: 4)
                        } else {
                            Button("Athletic") {
                                tripItem.occasion = "athletic"
                            }
                            .font(.title2)
                            .buttonStyle(.borderedProminent)
                            .foregroundStyle(Color.black)
                            .tint(Color("ath"))
                        }
                        Spacer()
                            .frame(width: 20.0)
                        if (tripItem.occasion == "casual") {
                            Button("Casual") {}
                                .font(.title2)
                                .buttonStyle(.borderedProminent)
                                .foregroundStyle(Color.black)
                                .tint(Color("cas"))
                                .border(Color.black, width: 4)
                        } else {
                            Button("Casual") {
                                tripItem.occasion = "casual"
                            }
                            .font(.title2)
                            .buttonStyle(.borderedProminent)
                            .foregroundStyle(Color.black)
                            .tint(Color("cas"))
                            
                        }
                    }//end of HStack
                    Spacer()
                        .frame(height: 125.0)
                    if (isSaved) {
                        NavigationLink(destination: Text("Hello")) {
                            Text("Continue")
                        }
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .foregroundStyle(Color.black)
                        .tint(Color("cre"))
                    } else {
                        Button("Create List ✔") {
                            if (tripItem.title == "" || tripItem.location == "" || tripItem.length == 0 || tripItem.occasion == "") {
                                didntComplete = true
                            } else {
                                didntComplete = false
                                viewModel.getCoordinates(for: tripItem.location)
                                fetchWeather()
                                let temperature = Int(1.8 * (weather?.main.temp ?? 0.0) + 32)
                                let description = weather?.weather.first?.description ?? ""
                                addTrip(temp: temperature, info: description)
                                isSaved = true
                            }
                        }
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .foregroundStyle(Color.black)
                        .tint(Color("cre"))
                    }
                }
            }
        }
    }
    
    func addTrip(temp: Int, info: String) {
        let recs = fetchRecs(temp: temp, info: info)
        let trip = TripItem(title: tripItem.title, location: tripItem.location, length: tripItem.length, occasion: tripItem.occasion, listItems: recs)
        modelContext.insert(trip)
    }
    
    private func fetchRecs(temp: Int, info: String) -> [ListItem] {
        var recs = [String] ()
        if (tripItem.occasion == "formal") {
            if (temp<32) {
                recs.append("Long dress / suit")
                recs.append("Sweater / Heavy coat")
                recs.append("Scarf")
                recs.append("Snow boots")
                recs.append("Gloves")
            }
            else if (temp<50) {
                recs.append("Dress and coat / suit")
                recs.append("Formal shoes")
            }
            else if (temp<75) {
                recs.append("Dress and sweater / suit")
                recs.append("Formal shoes")
            }
            else {
                recs.append("Sundress / dress shirt and pants")
                recs.append("Sunglasses")
                recs.append("Formal shoes")
            }
        }
        else if (tripItem.occasion == "athletic") {
            if (temp<32) {
                recs.append("Thermals")
                recs.append("Leggings (under shorts)")
                recs.append("Hoodie")
                recs.append("Thin puffer")
                recs.append("Beanie / gloves")
                recs.append("Sneakers")
            }
            else if (temp<50) {
                recs.append("Leggings (under shorts)")
                recs.append("Athletic t-shirt")
                recs.append("Quarter-zip")
                recs.append("Gloves")
                recs.append("Sneakers")
            }
            else if (temp<75) {
                recs.append("Leggings / shorts")
                recs.append("Athletic t-shirt")
                recs.append("Sneakers")
            }
            else {
                recs.append("Shorts")
                recs.append("Athletic tank top")
                recs.append("Sunglasses")
                recs.append("Sneakers")
            }
        }
        else if (tripItem.occasion == "casual") {
            if (temp<32) {
                recs.append("Thermals")
                recs.append("Jeans / sweatpants")
                recs.append("Hoodie")
                recs.append("Warm coat")
                recs.append("Beanie / gloves")
                recs.append("Snow boots")
            }
            else if (temp<50) {
                recs.append("Jeans")
                recs.append("T-shirt")
                recs.append("Sweatshirt")
                recs.append("Beanie / gloves")
                recs.append("Sneakers")
            }
            else if (temp<75) {
                recs.append("Jeans / leggings")
                recs.append("T-shirt")
                recs.append("Zip-up hoodie")
                recs.append("Sneakers")
            }
            else {
                recs.append("(Jean) shorts")
                recs.append("Tank top / t-shirt")
                recs.append("Sunglasses")
                recs.append("Sneakers / sandals")
            }
        }
        if info.contains("rain") || info.contains("storm") || info.contains("thunder") || info.contains("lightning"){
            recs.append("Raincoat")
        }
        if info.contains("hail") {
            recs.append("Helmet")
            recs.append("Waterproof jacket")
        }
        if info.contains("tornado") || info.contains("hurricane") {
            recs.append("Helmet")
        }
        
        var returner = [ListItem] ()
        for rec in recs {
            let newListItem = ListItem(name: rec, quantity: tripItem.length, isChecked: false)
            returner.append(newListItem)
        }
        return returner
    }
    
    //
    //
    //
    //
    //
    //
    //
    //RANDO WEATHER CODE IGNORE
    private func fetchWeather() {
        let weatherService = WeatherService()
        if let latitude = viewModel.latitude, let longitude = viewModel.longitude {
            weatherService.getWeather(latitude: latitude, longitude: longitude) { response in
                self.weather = response
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TripItem.self, ListItem.self, configurations: config)

    let trip = TripItem(title: "", location: "", length: 0, occasion: "", listItems: [ListItem(name: "", quantity: 0, isChecked: false)])
    return CreateView(tripItem: trip)
        .modelContainer(container)
}
