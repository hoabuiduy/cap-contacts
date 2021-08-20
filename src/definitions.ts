export interface CapContactsPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  getContacts(options: {
    name: string;
  }): Promise<{
    contacts: ContactDetail[];
  }>;
  pickContact(): Promise<{
    contact: ContactDetail;
  }>;
  checkPermission(): Promise<{
    granted: boolean;
  }>;
  requestPermission(): Promise<{
    granted: boolean;
  }>;
}

export interface ContactDetail {
  name: string;
  phone: string;
}
