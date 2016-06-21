# ArithmeticTools

[![Build Status](https://travis-ci.org/dn-m/ArithmeticTools.svg)](https://travis-ci.org/dn-m/ArithmeticTools)

Basic arithmetic types and operations. For iOS and OSX platforms.

***

<a name="integration"></a>
## Integration

### Carthage
Integrate **ArithmeticTools** into your OSX or iOS project with [Carthage](https://github.com/Carthage/Carthage).

1. Follow [these instructions](https://github.com/Carthage/Carthage#installing-carthage) to install Carthage, if necessary.
2. Add `github "dn-m/ArithmeticTools"` to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile) 
3. Follow [these instructions](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) to integrate **ArithmeticTools** into your OSX or iOS project.

***

## Usage

### ArithmeticType

The `protocol` **`ArithmeticType`** unifies [`IntegerLiteralConvertible`](http://swiftdoc.org/v2.1/protocol/IntegerLiteralConvertible/hierarchy/) types:

| IntegerType | FloatingPointType |
| ------------|-------------------|
|`Int`        | `Float`           |
|`In8`        | `Double`          |
|`UInt8`      |                   |
|`Int16`      |                   |
| `UInt16`    |                   |
|`Int32`      |                   |
|`UInt32`     |                   |
|`Int64`      |                   |
|`UInt64`     |                   |

#### Type Variables
| Name | Signature |
-------|-----------|
| **`zero`**| `zero: Bool` |
| **`one`**| `one: Bool` |
| **`min`**| `min: Self` |
| **`max`**| `max: Self` |

#### Type Methods
| Name | Signature |
-------|-----------|
| **`random`**| `random(min min: Self = ..., max: Self = ...) -> ` |

#### Instance Variables
| Name | Signature |
-------|-----------|
|**`isEven`**| `isEven: Bool`|
|**`isOdd`**| `isOdd: Bool` |
|**`isPrime`**| `isPrime: Bool`|
|**`format`**| `format(f: String) -> String` |

### SequenceType Extensions

#### Instance Variables
| Name | Signature |
-------|-----------|
|**`sum`**| `sum: Generator.Element`|
|**`gcd`**| `gcd: Generator.Element?` |

### Array Extensions

#### Instance Variables
| Name | Signature |
-------|-----------|
|**`mean`**|`mean: Float`|  
|**`cumulative`**|`cumulative: [Element]`|
|**`cumulativeWithValue`**|`cumulativeWithValue: [(Element, Element)]`|

### Free functions

| Name | Signature |
-------|-----------|
|**`greatestCommonDivisor`**|`greatestCommonDivisor((a: T, _ b: T) -> T`|

```Swift
greatestCommonDivisor(4,12) // 4
greatestCommonDivisor(6.0, 9.0) // 3.0
```
