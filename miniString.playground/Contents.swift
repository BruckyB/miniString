import UIKit

func countHi(str: String) -> Int {
    var c = 0
    var s = str.lowercased()
    var s2 = str.suffix(from: str.index(after:  str.startIndex))
    for a in s {
        for b in s2 {
            if a == "h" {
                if s2.prefix(1).contains("i") {
                    c += 1
                }
            }
            s = String(s.suffix(from: s.index(after:s.startIndex)))
            if s2.count != 0 {
                s2 = s2.suffix(from: s2.index(after: s2.startIndex))
            }
        }
    }
    return c
}

countHi(str: "hellohihihelloballs")



func endOther(str: String, str2: String) -> Bool {
    var s = str.lowercased()
    var s2 = str2.lowercased()
    if s.count <= s2.count{
        return false
    } else {if s.suffix(s2.count).contains(s2){
        return true
    }
    }
    return false
}


endOther(str: "balls", str2: "ls")

func sumNumber(str: String) -> Int {
    var s = str
    var c = 0
    var ye = ""
    while s.count > 0 {
        if s.first?.isNumber == true {
            for i in 0...9 {
                if s.first == Character(String(i)) {
                    ye += String(i)
                    break
                }
            }
        }
            if s.first?.isLetter == true || s.first?.isWhitespace == true {
                if let g = Int(ye) {
                    c += g
                    ye = ""
                }
            }
            s = String(s.suffix(s.count-1))
        }
        if s.count == 0 {
            if let g = Int(ye) {
                c += g
            }
        }
        
        
        
        
    
    return c
}
sumNumber(str: "p4o05p31")

