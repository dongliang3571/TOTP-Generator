## TOTP Generator

This is a time-based one time password generator(totp generator).

Based on two IETF documents:
- https://tools.ietf.org/html/rfc6238
- https://tools.ietf.org/html/rfc4226

### Screenshots

This is a menu bar application only

![Screenshot1](/screenshots/screenshot-1.png)
![Screenshot2](/screenshots/screenshot-2.png)

### Motivation

Many companies nowadays require their employees to use a multi-factor authentication. Like entering a one time password when doing authentication. There are many mobile apps like Google authenticator, but they only work on your phones. What if you want a Desktop version, this is why I built this app.

There might be similar apps out there, but you don't really know if they are safe or not. Are they sending your information to their servers? You don't know. That's another reason I built this application, you can see all the source code here.

### Requirements

- Currently only support for MacOS >= 10.12

### Download

Download the `.dmg` file [here](/build/TOTPGenerator.dmg)

### How to build from source code

1. Install Cocoapods https://cocoapods.org
2. Install dependencies

    ```bash
    pod install
    ```
3. Open `TOTPGenerator.xcworkspace` with XCode

4. From XCode menu, Product -> Archive -> Distribute App -> Export/Copy App

5. You should be able to find `TOTPGenerator.app` in the output folder.

### How to get secret

When you're asked to enable multi-factors authentication, you're either provided with a secret key or a QR code to scan.

1. With secret key, you can easily enter into this application and start using it
2. With QR Code, you have to decode it and extract the secret out of it. You can use this [QR Code decoder](https://dongliang3571.github.io/qrcode-decoder/) to get your secret out of a QR Code. Don't worry, I don't store any of your data, the source code is here https://github.com/dongliang3571/qrcode-decoder


### How to generate a `.dmg` image for your OS X applications

https://github.com/LinusU/node-appdmg

1. `npm install -g appdmg`
2. `appdmg <json-path> <dmg-path>`
3. Take the example of TOTP Generator, go to `build` folder and do `appdmg --verbose ./app.json ./TOTPGenerator.dmg`
