# react-native-keycommands

Use `UIKeyCommands` (iOS).

## Getting started

`$ npm install react-native-keycommands --save`

### Mostly automatic installation (RN < 0.60)

`$ react-native link react-native-keycommands`

### Manual installation (RN < 0.60)


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-keycommands` and add `KeyCommands.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libKeyCommands.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

Not need setup.

## Usage
```javascript
import React from 'react';
import KeyCommands, { constants } from 'react-native-keycommands';

const keyCommands = [
	{
		input: 'a',
		modifierFlags: 0, // without flags
		discoverabilityTitle: 'a pressed'
  },
  {
		input: 'a',
		modifierFlags: constants.keyModifierCommand,
		discoverabilityTitle: 'CMD + a pressed'
  },
  {
		input: 'a',
		modifierFlags: constants.keyModifierCommand | constants.keyModifierAlternate,
		discoverabilityTitle: 'CMD + ALTERNATE + a pressed'
  }
];

export default class App extends React.Component {
  onKeyCommand = ({ nativeEvent }) => {
		console.log('event: ', nativeEvent);
  };
  
  render() {
    <KeyCommands
      style={{ flex: 1 }}
      keyCommands={keyCommands}
      onKeyCommand={this.onKeyCommand}
    />
  }
};

```
