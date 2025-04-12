struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    var amount: Int
    var currency: String
    let acceptedCurrs = ["USD", "GBP", "EUR", "CAN"]

    func convert(_ to: String) -> Money {
        var newAmount = amount
//        var newCurrency: String
        if !acceptedCurrs.contains(to) {
            print("Currency not accepted")
        } else {
            if currency != "USD" {
                newAmount = convertToUSD()
            }
            if to == "USD" {
                return Money(amount: newAmount, currency: to)
            } else if to == "GBP" {
//                newCurrency = "GBP"
                newAmount = Int(0.5 * Double(amount))
            } else if to == "EUR" {
//                newCurrency = "EUR"
                newAmount = Int(1.5 * Double(amount))
            } else {
//                newCurrency = "CAN"
                newAmount = Int(1.25 * Double(amount))
            }
        }
        return Money(amount: newAmount, currency: to)
    }
    
    func convertToUSD() -> Int {
        var usdamount: Int = 0
        if currency == "GBP" {
            usdamount = Int(2 * Double(amount))
        } else if currency == "EUR" {
            usdamount = Int(Double(amount) * 2 / 3)
        } else {
            usdamount = Int(Double(amount) * 4 / 5)
        }
//        currency = "USD" // temporary while converting
        return usdamount
    }
    
    func add(_ other: Money) -> Money {
        // convert to self.currency ❎
        let curr = self.currency
        // convert to other.currency
        let newMoney = self.convert(other.currency)
        // then add
        let newAmount = other.amount + newMoney.amount
        let addedMoney = Money(amount: newAmount, currency: other.currency)
        // convert back to initial currency
        
        return addedMoney.convert(curr)
    }
    
    func subtract(_ other: Money) -> Money {
        // convert to self.currency ❎
        let curr = self.currency
        // convert to other.currency
        let newMoney = self.convert(other.currency)
        // then add
        let newAmount = newMoney.amount - other.amount
        let addedMoney = Money(amount: newAmount, currency: other.currency)
        // convert back to initial currency
        
        return addedMoney.convert(curr)
    }
}

////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    var type : JobType
    var title : String
    
    func calculateIncome() -> Int {
        switch type {
        case .Hourly(let double):
            <#code#>
        case .Salary(let uInt):
            return type.Salary
        }
        return -1
    }
}

////////////////////////////////////
// Person
//
public class Person {
}

////////////////////////////////////
// Family
//
public class Family {
}
