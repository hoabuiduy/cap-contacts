export interface CapContactsPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
