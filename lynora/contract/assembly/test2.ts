/**
 * Test contract without constructor
 */

import {
  generateEvent,
} from '@massalabs/massa-as-sdk';

/**
 * Simple test function
 */
export function hello(_args: StaticArray<u8>): void {
  generateEvent('Hello from test contract!');
}
