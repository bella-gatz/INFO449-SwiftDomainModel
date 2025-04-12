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
      
    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
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
    
    init(title: String, type: JobType) {
        self.type = type
        self.title = title
    }
    
    func calculateIncome(_ hours : Int) -> Int {
        switch type {
        case .Hourly(let double):
            return Int(double * Double(hours))
        case .Salary(let uInt):
            return Int(uInt)
        }
    }
    
    func raise(byAmount : Double)  {
        switch type {
        case .Hourly(let double):
            type = .Hourly(double + byAmount)
        case .Salary(let uInt):
            type = .Salary(uInt + UInt(byAmount))
        }
    }
    
    func raise(byPercent : Double) {
        switch type {
        case .Hourly(let double):
            type = .Hourly(double * (1 + byPercent))
        case .Salary(let uInt):
            type = .Salary(uInt * (1 + UInt(byPercent)))
        }
    }
}

////////////////////////////////////
// Person
//
public class Person {
    var firstName : String
    var lastName : String
    var age : Int
    var job : Job?
    var spouse : Person?
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    func toString() -> String {
        
        return "Person: firstName: \(firstName) lastName: \(lastName) age: \(age) job: \(job) spouse: \(spouse)"
    }
    
}

////////////////////////////////////
// Family
//
public class Family {
}
