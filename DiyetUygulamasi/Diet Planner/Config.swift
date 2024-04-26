
import Foundation

var STATUS = 1

var planCategories = ["Kilo Verme", "Kan Basıncı", "Gluttensiz", "Sütsüz", "Şeker", "Temiz Beslenme", "Vejetaryen", "Diğer"]

var kiloVerme = ["Aylık Kilo Verme", "Haftalık Kilo Verme"]
var kanBasinci = ["Kan Basıncı", "1200 Kalori BP", "1500 Kalori BP", "2000 Kalori", "7 Günlük Kan Basıncı"]
var gluttensiz = ["7 Gün Gluttensiz", "Gluttensiz"]
var sutsuz = ["Süt Ürünleri İçermez", "Sağlıklı Gebelik", "1200 Kalori", "1500 Kalori"]
var sekersiz = ["Diyabet", "Şeker-Detoks", "Şekersiz"]
var temizBeslenme = ["Başlangıç", "İleri Düzey", "Orta"]
var vejetaryen = ["7 Günde Kilo Verme", "7 Günde Sağlıklı"]
var digerleri = ["7 Gün Akdeniz", "Eleme"]

func getJSONFileName(categoryIndex: Int, subCategoryIndex: Int) -> String {
    var jsonFile = ""
    switch categoryIndex {
    case 0:
        jsonFile = kiloVerme[subCategoryIndex]
        break
    
    case 1:
        jsonFile = kanBasıncı[subCategoryIndex]
        break
    
    case 2:
        jsonFile = gluttensiz[subCategoryIndex]
        break
    
    case 3:
        jsonFile = sütsüz[subCategoryIndex]
        break
   
    case 4:
        jsonFile = şekersiz[subCategoryIndex]
        break
    
    case 5:
        jsonFile = temizBeslenme[subCategoryIndex]
        break
    
    case 6:
        jsonFile = vejetaryen[subCategoryIndex]
        break
    
    case 7:
        jsonFile = diğerleri[subCategoryIndex]
        break
    
    default:
        jsonFile = ""
        break
    }
    //print(jsonFile)
    return jsonFile
}

func getJSONData(jsonFile: String) -> [[String: String]] {
    if let path = Bundle.main.path(forResource: jsonFile, ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonObject = jsonResult as? [String:Any] {
                print(jsonObject)
                let jsonArray = jsonObject["data"] as! [[String:String]]
                return jsonArray
            }
        } catch {
            print("Error reading data")
            return [[String: String]]()
        }
    }
    return [[String: String]]()
}
