import Foundation

let base = 10.0
func ipow(_ base: UInt, _ pow: UInt) -> UInt {
  return (1..<pow).reduce(base) { res, _ in res * base }
}

func addIntegers(byDigit s0: String, _ s1: String, _ s2: String) -> String {
  let a0 = s0.map{ $0.wholeNumberValue! }, a1 = s1.map{ $0.wholeNumberValue! }, a2 = s2.map{ $0.wholeNumberValue! }
  let length = max(a0.count, a1.count, a2.count)
  
  // working values
  var carryover = 0
  var result = ""
  
  // iterate digits backwards and prepend to result
  for i in 1...length {
    let val0 = a0.count >= i ? a0[a0.count-i] : 0
    let val1 = a1.count >= i ? a1[a1.count-i] : 0
    let val2 = a2.count >= i ? a2[a2.count-i] : 0

    let sum = val0 + val1 + val2 + carryover
    let modulus = sum % 10
    carryover = sum / 10
    result.insert(contentsOf: String(modulus), at: result.startIndex)
  }
  
  if carryover > 0 {
    result.insert(contentsOf: String(carryover), at: result.startIndex)
  }
  
  return result
}

func subtractIntegers(from s0: String, minus s1: String, minus s2: String) -> String {
  let a0 = s0.map{ $0.wholeNumberValue! }, a1 = s1.map{ $0.wholeNumberValue! }, a2 = s2.map{ $0.wholeNumberValue! }
  let length = a0.count
  
  // working values
  var carryover = 0
  var result = ""
  var zeros = ""
  
  // iterate digits backwards and prepend to result
  for i in 1...length {
    let val0 = a0.count >= i ? a0[a0.count-i] : 0
    let val1 = a1.count >= i ? a1[a1.count-i] : 0
    let val2 = a2.count >= i ? a2[a2.count-i] : 0

    let res = val0 - val1 - val2 - carryover
    if res < 0 {
      carryover = abs((res+1) / 10) + 1
      let digit = res % 10 != 0 ? (res % 10) + 10 : 0
      if digit == 0 {
        zeros.append("0")
      } else {
        result.insert(contentsOf: "\(digit)\(zeros)", at: result.startIndex)
        zeros = ""
      }
    } else if res == 0 {
      carryover = 0
      zeros.append("0") // carry the zero and insert when needed again
    } else {
      carryover = 0
      result.insert(contentsOf: "\(res)\(zeros)", at: result.startIndex)
      zeros = ""
    }
  }
  return result
}

func karatsuba(_ num1: String, _ num2: String) -> String {
  if num1.count <= 1 || num2.count <= 1 {
    return String(UInt(num1)! * UInt(num2)!)
  }
    
  let length = min(num1.count, num2.count)
  let mid = length / 2
  
  // split num1 at mid
  let index1 = num1.index(num1.endIndex, offsetBy: -mid)
  let high1 = String(num1[num1.startIndex..<index1])
  let low1 = String(num1[index1..<num1.endIndex])
  // split num2 at mid
  let index2 = num2.index(num2.endIndex, offsetBy: -mid)
  let high2 = String(num2[num2.startIndex..<index2])
  let low2 = String(num2[index2..<num2.endIndex])
  
  let z0 = karatsuba(low1, low2)
  let z1 = karatsuba(addIntegers(byDigit: low1, high1, "0"), addIntegers(byDigit: low2, high2, "0"))
  let z2 = karatsuba(high1, high2)
  //Swift.print("z0=\(z0)\nz1=\(z1)\nz2=\(z2)\n")
  
  let p2 = z2.appending(String(repeating: "0", count: mid*2)) // shift by  10^2mid
  let p1 = subtractIntegers(from: z1, minus: z2, minus: z0).appending(String(repeating: "0", count: mid)) // shift by 10^mid
  return addIntegers(byDigit: p2, p1, z0)
}

//let num1 = "765438810"
//let num2 = "543215098"
//print("Mult: \(Int(num1)! * Int(num2)!)")
//print("Kara: \(karatsuba(num1, num2))")

let num4 = "3141592653589793238462643383279502884197169399375105820974944592"
let num5 = "2718281828459045235360287471352662497757247093699959574966967627"
// 8539734222673567065463550869546574495034888535765114961879601127067743044893204848617875072216249073013374895871952806582723184

//let val = karatsuba(num4, num5)
//print(val)

let num6 = "3141592653589793238462643383279502884197169399375105820974944592314159265358979323846264338327950288419716939937510582097494459231415926535897932384626433832795028841971693993751058209749445923141592653589793238462643383279502884197169399375105820974944592"
let num7 = "2718281828459045235360287471352662497757247093699959574966967627271828182845904523536028747135266249775724709369995957496696762727182818284590452353602874713526624977572470936999595749669676272718281828459045235360287471352662497757247093699959574966967627"
// 8539734222673567065463550869546574495034888535765114961879601128775689889427918261710585246125563972020352603024975798958643409669740635658847981687481540529647049453721635247344010172932670646191228237490413720390455644673770170540801019219044045000100030832892446374889514110565549728968640563966144217345714894773074291117597921432795894633539055806211804710239476888141212408977749894595120537664037821052313871555955302386453204171093534064807067743044893204848617875072216249073013374895871952806582723184

let val = karatsuba(num6, num7)
print(val)

//print("Added:  \(Int(num1)! + Int(num2)! + Int(num4)!)")
//print("addInt: \(addIntegers(byDigit: num1, num2, num4))")

//let big = "1888880", minus1 = "88888", minus2 = "99999"
//print(Int(big)! - Int(minus1)! - Int(minus2)!)
//print(subtractIntegers(from: big, minus: minus1, minus: minus2))

