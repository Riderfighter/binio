# Important
> This package is a direct port of [Zeroeh's binio for golang](https://github.com/Zeroeh/binio) to nim.

# About
> A package to write structured data to a bytes buffer, which is a technique commonly used in games where text-based protocols such as xml or json carry too much bulk to efficiently transfer data over the wire. The package is similar to Google's protocol buffers in that it is meant to be language agnostic with its intended function, but cuts out the overhead of using protocol buffers and compiling templates for each type.

# Usage
> Refer to `example/example.nim` for usage and examples.

# Notes
> The package was originally developed to be used for a specific game. You may have to change some of the functions to suit your individual needs.

> A requirement of this package is the [struct package](https://github.com/OpenSystemsLab/struct.nim) which can be gotten directly from nimble. For example:
```
nimble install struct
```