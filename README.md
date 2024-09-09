## Build tools & versions used
XCode v. 15.4 with Swift and SwiftUI

## Steps to run the app
Simple running of the app will load the employee list to the root view. Pull down refresh will empty the current list to update the UI with most recent requested data and cached images are loaded if the URL exists already

## What areas of the app did you focus on?
UI for the employee cards, custom small image cache, async await networking layer with generic object setting for parsing and flexibility, MVVM architecture, SwiftUI functionality for ease of readability, testing with some abstraction. 

## What was the reason for your focus? What problems were you trying to solve?
Testing and custom cache. For the testing I wanted to make sure that the things that could be tested should be. For the image cache, in my research for this i found it better to use the tools that Apple has provided and create a small method to handle it, as with SwiftUI was very good and compact for my approach.

## How long did you spend on this project?
About 5.5 hours

## Did you make any trade-offs for this project? What would you have done differently with more time?
One trade off was having the employee list once populated live within the app instead of just one view. I would have created the list as a separate globally accessible object to cut down on calls to populate unless absolutely necessary if I had more time. Also more testing, a more robust caching service, and some UX updates. 

## What do you think is the weakest part of your project?
Testing at the moment. With more time, I could implement more robust unit testing that will jeep the project on the right path when changes are made.

## Did you copy any code or dependencies? Please make sure to attribute them here!
I built a custom image cache using the following resources. If there is a native solution that can be simplified, I will try to find it. My solution incorporated well with SwiftUI and AsyncImage
https://developer.apple.com/documentation/foundation/nscache
https://stackoverflow.com/questions/68854131/how-do-i-access-the-image-in-asyncimage-to-save-the-image-after-its-been-retrie
https://stackoverflow.com/questions/57028484/how-to-convert-an-image-to-uiimage
https://forums.developer.apple.com/forums/thread/118172

## Is there any other information you’d like us to know?
This is great project for a tech interview because it reflects more on what day to day work will be like. It was fun to work on.


