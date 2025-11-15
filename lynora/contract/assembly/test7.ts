/**
 * Test contract with empty constructor
 */

import {
  generateEvent,
} from '@massalabs/massa-as-sdk';

export function constructor(_args: StaticArray<u8>): void {
  generateEvent('Empty constructor test');
}
