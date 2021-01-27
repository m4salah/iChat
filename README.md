# iChat
This is the final capstone project app for Udacity iOS Developer Nanodegree. This is simple messanger app allow any number of user texting each other in the same room, but it perfare two user only.

 * [Project Rubric](https://review.udacity.com/#!/rubrics/1991/view)

## This project focused on
* Design and build an app from the ground up
* Build sophisticated and polished user interfaces with UIKit components
* using firebase to store and retrive the message data 
* Using Firebase Framework for Authenticationa and Real-Time Database

## App Structure
iChat is following the MVC pattern

## Implementation
### main screen 
main screen contain two option Register optin if user doesnit have already account or login if they have.

### Registration Screen
This screan contain two textfield to register email and password,
immediatly after register succefully you will move to the chat screen.

### chat screen
chat screen contain tableview to show the messages, textfield to type the message you want and the send button the send your message and store it in the cloud

## Environment
This app was created with the following environment in mind:

* XCode 11.4
* Swift 5.1

#### Cocoa Pods
This project uses CocoaPods for it's dependencies. To initalize the project you should first install CocoaPods and then initialize the dependencies by running

```console
pod install
```

After that, open the project using the iMessenger.xcworkspace created by CocoaPods.


## Frameworks
UIKit

Firebase Authentication

Firebase Database

