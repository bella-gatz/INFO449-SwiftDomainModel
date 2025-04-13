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
        // convert to other.currency
        let newMoney = self.convert(other.currency)
        // then add (both in other currency)
        let newAmount = newMoney.amount + other.amount
        let addedMoney = Money(amount: newAmount, currency: other.currency)
        
        return addedMoney
    }
    
    func subtract(_ other: Money) -> Money {

        // convert to other.currency
        let newMoney = self.convert(other.currency)
        // then add
        let newAmount = newMoney.amount - other.amount
        let addedMoney = Money(amount: newAmount, currency: other.currency)
        
        return addedMoney
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
            type = .Salary(UInt(Double(uInt) * (1 + byPercent)))
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
    var job : Job? {
        didSet {
            if age < 21 {
                job = nil
            }
        }
    }
    
    var spouse : Person? {
        didSet {
            if age < 21 {
                spouse = nil
            }
        }
    }
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
    }
    
}

////////////////////////////////////
// Family
//
public class Family {
    var members : [Person] = []
    
    init(spouse1 : Person, spouse2 : Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil {
            self.members.append(spouse1)
            self.members.append(spouse2)
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
        }
    }
    
    func haveChild(_ child : Person) -> Bool {
        if self.members.count <= 2 {
            if members[0].age > 21 || members[1].age > 21 {
                self.members.append(child)
                return true
            }
        }
        return false
    }
    
    func householdIncome() -> Int {
        var totalIncome = 0
        for member in self.members {
            if let job = member.job {
                totalIncome += job.calculateIncome(2000)
            }
        }
        return totalIncome
    }
}
