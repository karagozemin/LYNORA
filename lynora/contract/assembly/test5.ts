/**
 * Test contract without Storage - just Context
 */

import {
  generateEvent,
  Context,
} from '@massalabs/massa-as-sdk';

export function constructor(_args: StaticArray<u8>): void {
  const time = Context.timestamp();
  generateEvent('Test with Context.timestamp: ' + time.toString());
}
