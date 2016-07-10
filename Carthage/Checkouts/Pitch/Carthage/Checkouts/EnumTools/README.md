# EnumTools

[![Build Status](https://travis-ci.org/dn-m/EnumTools.svg?branch=master)](https://travis-ci.org/dn-m/EnumTools)

Tools for Swift Enum 

***

<a name="integration"></a>
## Integration

### Carthage
Integrate **EnumTools** into your OSX or iOS project with [Carthage](https://github.com/Carthage/Carthage).

1. Follow [these instructions](https://github.com/Carthage/Carthage#installing-carthage) to install Carthage, if necessary.
2. Add `github "dn-m/EnumTools"` to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile) 
3. Follow [these instructions](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) to integrate **EnumTools** into your OSX or iOS project.

***

## Usage

The implementation of this is from [here](http://stackoverflow.com/a/28341290).

```Swift
enum TestEnum { case A, B, C }
```

```Swift
var allEnums: [TestEnum] = []
for e in iterateEnum(TestEnum) { allEnums.append(e) }
// [.A, .B, .C]
```
