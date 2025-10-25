// Sample TypeScript definition file for testing

export interface Person {
  name: string;
  age: number;
  isActive: boolean;
}

export class User {
  constructor(name: string, email: string);

  getName(): string;
  setName(name: string): void;

  static createDefault(): User;
}

export function greet(person: Person): string;

export type UserID = string | number;

export enum Status {
  Active = 1,
  Inactive = 0,
  Pending = 2,
}
