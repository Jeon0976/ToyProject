import UIKit


// Target
protocol NewJsonParser {
    func parse(data: Data) -> [String: Any?]
}

// Adaptee
class OldJsonParser {
    func specificParse(from data: Data) -> [String: Any]? {
        // Parsing Logic
        return nil
    }
}

// Adapter
class JsonParserAdapter: NewJsonParser {
    var oldParser: OldJsonParser
    
    init(oldParser: OldJsonParser) {
        self.oldParser = oldParser
    }
    
    func parse(data: Data) -> [String: Any?] {
        return oldParser.specificParse(from: data)!
    }
}

// Clinet
let oldParser = OldJsonParser()
let adapter = JsonParserAdapter(oldParser: oldParser)
let jsonData = Data()
let result = adapter.parse(data: jsonData)
