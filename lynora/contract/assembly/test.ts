/**
 * Simple test contract to verify deployment works
 */

import {
  Storage,
  generateEvent,
} from '@massalabs/massa-as-sdk';

/**
 * Initialize the contract
 */
export function constructor(_args: StaticArray<u8>): void {
  generateEvent('Test contract initialized');
}

/**
 * Simple test function
 */
export function hello(_args: StaticArray<u8>): void {
  generateEvent('Hello from test contract!');
}
