//
//  Income.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 27.06.2021.
//

import UIKit

struct IncomeAndExpences {
  let type: String?
  let amount: String
}

final class IncomeAndExpencesFactory {
  
  static func makeIncome() -> [IncomeAndExpences] {
    
    let incomePlaceholder = IncomeAndExpences(type: "Monthly Income:", amount: " ")
    let income1 = IncomeAndExpences(type: "Salary", amount: "3.000 ₽")
    let income2 = IncomeAndExpences(type: "Stocks", amount: "2.000 ₽")
    let income3 = IncomeAndExpences(type: "Rent", amount: "500 ₽")
    
    return [
      incomePlaceholder,
      income1,
      income2,
      income3
    ]
  }
  
  static func makeExpences() -> [IncomeAndExpences] {
    
    let expencesPlaceholder = IncomeAndExpences(type: "Monthly Expences:", amount: " ")
    let expences1 = IncomeAndExpences(type: "Groceries", amount: "300 ₽")
    let expences2 = IncomeAndExpences(type: "Taxes", amount: "200 ₽")
    let expences3 = IncomeAndExpences(type: "Journeys", amount: "3.000 ₽")
    
    return [
      expencesPlaceholder,
      expences1,
      expences2,
      expences3
    ]
  }
  
}
