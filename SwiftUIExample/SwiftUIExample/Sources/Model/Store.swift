//
//  Store.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/27/24.
//

import Foundation

final class Store: ObservableObject {
    @Published var appSetting: AppSetting
    @Published var products: [Product]
    @Published var orders: [Order] = [] {
        didSet {
            saveData(at: ordersFilePath, data: orders)
        }
    }
    
    init(
        filename: String = "ProductData",
        appSetting: AppSetting = AppSetting()
    ) {
        self.appSetting = appSetting
        
        self.products = Bundle.main.jsonDecode(filename: filename, as: [Product].self)
        self.orders = loadData(at: ordersFilePath, type: [Order].self)
    }
}

extension Store {
    func toggleFavorite(of product: Product) {
        guard let index = products.firstIndex(of: product) else { return }
        
        products[index].isFavorite.toggle()
    }
    
    func placeOrder(product: Product, quantity: Int) {
        let nextID = Order.orderSequence.next()!
        
        let order = Order(id: nextID, product: product, quantity: quantity)
    
        orders.append(order)
        Order.lastOrderID = nextID
    }
    
    func deleteOrder(at indexes: IndexSet) {
        guard let index = indexes.first else { return }
        orders.remove(at: index)
    }
    
    func moveOrder(from indexs: IndexSet, to destination: Int) {
        orders.move(fromOffsets: indexs, toOffset: destination)
    }
}

private extension Store {
    var ordersFilePath: URL {
        let manager = FileManager.default
        let appSupportDir = manager.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ).first!
        
        let bundleID = Bundle.main.bundleIdentifier ?? "FruitMart"
        
        let appDir = appSupportDir.appending(path: bundleID, directoryHint: .isDirectory)
        
        if !manager.fileExists(atPath: appDir.path(percentEncoded: true)) {
            try? manager.createDirectory(at: appDir, withIntermediateDirectories: true)
        }

        return appDir
            .appending(path: "Orders", directoryHint: .isDirectory)
            .appendingPathExtension("json")
    }
    
    func saveData<T>(at path: URL, data: T) where T: Encodable {
        do {
            let data = try JSONEncoder().encode(data)
            try data.write(to: path)
        } catch {
            print(error)
        }
    }
    
    func loadData<T>(at path: URL, type: [T].Type) -> [T] where T: Decodable {
        do {
            let data = try Data(contentsOf: path)
            let decodedData = try JSONDecoder().decode(type, from: data)
            
            return decodedData
        } catch {
            return []
        }
    }
}
