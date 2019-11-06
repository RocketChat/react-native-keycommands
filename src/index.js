var __rest = (this && this.__rest) || function (s, e) {
  var t = {};
  for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
      t[p] = s[p];
  if (s != null && typeof Object.getOwnPropertySymbols === "function")
      for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) if (e.indexOf(p[i]) < 0)
          t[p[i]] = s[p[i]];
  return t;
};
import { NativeModules, StyleSheet, requireNativeComponent, Platform, View } from 'react-native';
import React from 'react';
const { KeyCommandConstants } = NativeModules;
const RCTKeyCommands = requireNativeComponent('RCTKeyCommands');
const defaultStyles = StyleSheet.create({
  main: {
      backgroundColor: 'transparent'
  }
});
const isAndroid = Platform.OS === 'android';

export const constants = {
  keyModifierShift: !isAndroid ? KeyCommandConstants.keyModifierShift : null,
  keyModifierControl: !isAndroid ? KeyCommandConstants.keyModifierControl : null,
  keyModifierAlternate: !isAndroid ? KeyCommandConstants.keyModifierAlternate : null,
  keyModifierCommand: !isAndroid ? KeyCommandConstants.keyModifierCommand : null,
  keyModifierNumericPad: !isAndroid ? KeyCommandConstants.keyModifierNumericPad : null,
  keyInputUpArrow: !isAndroid ? KeyCommandConstants.keyInputUpArrow : null,
  keyInputDownArrow: !isAndroid ? KeyCommandConstants.keyInputDownArrow : null,
  keyInputLeftArrow: !isAndroid ? KeyCommandConstants.keyInputLeftArrow : null,
  keyInputRightArrow: !isAndroid ? KeyCommandConstants.keyInputRightArrow : null,
  keyInputEscape: !isAndroid ? KeyCommandConstants.keyInputEscape : null,
};
export default class KeyCommands extends React.Component {
  render() {
      const _a = this.props, { style } = _a, props = __rest(_a, ["style"]);
      if (isAndroid) {
          return (
            <View
              {...Object.assign({}, props, { style: [defaultStyles.main, style] })}
            />
          );
      }
      return (<RCTKeyCommands {...Object.assign({}, props, { style: [defaultStyles.main, style] })}/>);
  }
}
