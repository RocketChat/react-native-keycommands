import { NativeModules, NativeEventEmitter, Platform } from 'react-native';

const isAndroid = Platform.OS === 'android';

const { KeyCommandConstants, KeyCommandsManager } = NativeModules;
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

export const KeyCommandsEmitter = !isAndroid ? new NativeEventEmitter(KeyCommandsManager) : {
  addListener: () => {}
};

export default !isAndroid ? KeyCommandsManager : {
  setKeyCommands: () => {},
  deleteKeyCommands: () => {}
};
