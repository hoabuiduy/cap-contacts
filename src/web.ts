import { WebPlugin } from '@capacitor/core';

import type { CapContactsPlugin } from './definitions';

export class CapContactsWeb extends WebPlugin implements CapContactsPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
