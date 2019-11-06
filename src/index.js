import { NativeModules, NativeEventEmitter } from 'react-native';

const { KeyCommandConstants, KeyCommandsManager } = NativeModules;
export const constants = {
  keyModifierShift: KeyCommandConstants.keyModifierShift,
  keyModifierControl: KeyCommandConstants.keyModifierControl,
  keyModifierAlternate: KeyCommandConstants.keyModifierAlternate,
  keyModifierCommand: KeyCommandConstants.keyModifierCommand,
  keyModifierNumericPad: KeyCommandConstants.keyModifierNumericPad,
  keyInputUpArrow: KeyCommandConstants.keyInputUpArrow,
  keyInputDownArrow: KeyCommandConstants.keyInputDownArrow,
  keyInputLeftArrow: KeyCommandConstants.keyInputLeftArrow,
  keyInputRightArrow: KeyCommandConstants.keyInputRightArrow,
  keyInputEscape: KeyCommandConstants.keyInputEscape,
};

export const KeyCommandsEmitter = new NativeEventEmitter(KeyCommandsManager);

export default KeyCommandsManager;
