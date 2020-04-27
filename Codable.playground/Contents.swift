import Foundation

// MARK: - Struct properties and json keys are same

struct Country: Codable {
    let name: String
    let language: String
    let continent: Continent
}

enum Continent: String, Codable {
    case Africa
    case Asia
    case Europe
    case NorthAmerica
    case SouthAmerica
    case Antarctica
    case Australia
}

let json = """
{
    "name": "China",
    "language": "Chinese",
    "continent": "Asia"
}
"""
let jsonData = json.data(using: .utf8)!

let country = try JSONDecoder().decode(Country.self, from: jsonData)
print(country.name, country.language, country.continent)
// China Chinese Asia

// MARK: - Struct properties and json keys are not same

struct Country2: Codable {
    let nationName: String
    let speakingLanguage: String
    let continent: Continent
    
    enum CodingKeys: String, CodingKey {
        case nationName = "name"
        case speakingLanguage = "language"
        case continent
    }
}

let json2 = """
{
    "name": "China",
    "language": "Chinese",
    "continent": "Asia",
    "capital": {
        "name": "Beijing",
        "population": 20000000
    }
}
"""
let jsonData2 = json2.data(using: .utf8)!

let country2 = try JSONDecoder().decode(Country2.self, from: jsonData2)
print(country2.nationName, country2.speakingLanguage, country2.continent)
// China Chinese Asia

// MARK: - Nested Struct

struct Capital: Codable {
    let name: String
    let population: Int
}

struct Country3: Codable {
    let name: String
    let language: String
    let continent: Continent
    let capital: Capital
}

let json3 = """
{
    "name": "China",
    "language": "Chinese",
    "continent": "Asia",
    "capital": {
        "name": "Beijing",
        "population": 20000000
    }
}
"""
let jsonData3 = json3.data(using: .utf8)!

let country3 = try JSONDecoder().decode(Country3.self, from: jsonData3)
print(country3.name, country3.language, country3.continent, country3.capital)
// China Chinese Asia Capital(name: "Beijing", population: 20000000)

// MARK: - Struct Array
let json4 = """
[   {
        "name": "China",
        "language": "Chinese",
        "continent": "Asia"
    },
    {
        "name": "England",
        "language": "English",
        "continent": "Europe"
    }
]
"""
let jsonData4 = json4.data(using: .utf8)!

let countries = try JSONDecoder().decode([Country].self, from: jsonData4)
print(countries[0].name, countries[1].name)
// China England
