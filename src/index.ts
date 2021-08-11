import { registerPlugin } from '@capacitor/core';

import type { CapContactsPlugin } from './definitions';

const CapContacts = registerPlugin<CapContactsPlugin>('CapContacts', {
  web: () => import('./web').then(m => new m.CapContactsWeb()),
});

export * from './definitions';
export { CapContacts };
