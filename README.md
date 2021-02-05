# swift-algorithms
Messing around with algorithms in Swift playgrounds

These samples are for educational purposes only, and can likely be refactored into production ready code with some cleanup and structure needed

## Karatsuba

Implemented the recursive solution for fast multiplication of base 10 integers by wrapping values in Strings, which are implemented as a Collection of Characters in Swift. Strings allow for the multiplication of any sized number, rather than being bound by 64 bit ints and lossy floating point primitives.

Karatsuba divides and conquers multiplication down to single digit integer operations, although the simple base case in the recursion could be updated to any minimum number of digits. 

The Addition and Subtraction operations of string values was implemented by calculating each operation for each integer digit in reverse order (right to left).
