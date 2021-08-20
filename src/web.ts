import { WebPlugin } from '@capacitor/core';

import { CapContactsPlugin, ContactDetail } from './definitions';

export class CapContactsWeb extends WebPlugin implements CapContactsPlugin {
  requestPermission(): Promise<{ granted: boolean }> {
    throw new Error('Method not implemented.');
  }
  pickContact(): Promise<{ contact: ContactDetail }> {
    throw new Error('Method not implemented.');
  }

  checkPermission(): Promise<{ granted: boolean }> {
    throw new Error('Method not implemented.');
  }

  getContacts(_options: {
    name: string;
  }): Promise<{
    contacts: ContactDetail[];
  }> {
    throw new Error('Method not implemented.');
  }
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
