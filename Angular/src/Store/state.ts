import { User } from "src/app/Model/User";

export class SetUser {
    static readonly type = '[Auth] SetUer';
    constructor(public data: User | null) {}
  }

  export class SetIsAuth {
    static readonly type = '[Auth] IsAUTH';
    constructor(public data : boolean) {}
  }

  
  export class Logout {
    static readonly type = '[Auth] Logout';
  }