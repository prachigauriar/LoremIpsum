# Lorem Ipsum Service

This is a simple macOS Services bundle for generating Lorem Ipsum text. It is written in Swift and performs no network
requests.

This project is heavily influenced by the [lipService][lipService] project. Specifically, the general approach and the
data used in `Lexicon.plist` comes from that project. However, all code was written by me. It’s pretty simple.


## To Install

The easiest way to install this service is using Xcode, navigate to the project directory, and execute the following
from the command-line.

    xcodebuild install DSTROOT="$HOME"

This will install the service in ~/Library/Services. Afterwards, you may need to log out and back in again to get the
Services menu to notice the two new services.


## License

All code is licensed under the MIT license. Do with it as you will.


[lipService]: https://github.com/geckocircle/lipService