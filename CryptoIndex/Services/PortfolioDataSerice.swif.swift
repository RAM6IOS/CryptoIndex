//
//  PortfolioDataSerice.swif.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 3/6/2022.
//

import Foundation
import CoreData
import Combine

class PortfolioDataService {
    private let cointainer :NSPersistentContainer
    private let cointainerName : String = "PortfolioContainer"
    private let entityName : String = "PortfolioEntity"

    @Published  var savedEntities : [PortfolioEntity] = []
    init(){
        cointainer = NSPersistentContainer(name: cointainerName)
        cointainer.loadPersistentStores{ (_ , error) in
            if let error = error {
                print("Error loading Core Data \(error)")
            }
            self.getProtfolio()
           
            
        }
    }
    
    func updatePortfolio(coin: CoinModel , amount:Double){
        
        if let entity =  savedEntities.first(where: { $0.coinID == coin.id}) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else{
                delete(entity: entity)
            }
        }
        else {
            add(coin: coin, amount: amount)
            
        }
    }
    
    func getProtfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do{
            savedEntities = try cointainer.viewContext.fetch(request)
        } catch let error {
            
            print("Error fatching Protflio \(error)")
            
        }
    }
    
    
    
    private func add(coin:CoinModel , amount: Double){
        let entity = PortfolioEntity(context: cointainer.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    private func update(entity:PortfolioEntity , amount:Double){
        entity.amount = amount
        applyChanges()
        
        
    }
    private func delete(entity: PortfolioEntity){
        cointainer.viewContext.delete(entity)
        applyChanges()
        
        
    }
    
    private func save(){
        do{
            try cointainer.viewContext.save()
            
        } catch let error {
            print("Error saving to Core Data \(error)")
            
        }
        
    }
    
    private func applyChanges(){
        save()
        getProtfolio()
    }
    
    
    
}
