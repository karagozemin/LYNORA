/**
 * Test contract with Storage
 */

import {
  Storage,
  generateEvent,
} from '@massalabs/massa-as-sdk';
import {
  stringToBytes,
  u64ToBytes,
} from '@massalabs/as-types';

const TEST_KEY = stringToBytes('TEST_KEY');

export function constructor(_args: StaticArray<u8>): void {
  Storage.set(TEST_KEY, u64ToBytes(1));
  generateEvent('Test contract with Storage initialized');
}
