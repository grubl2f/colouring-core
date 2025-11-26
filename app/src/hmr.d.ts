/* augments the global NodeModule for old TypeScript */
declare interface NodeModule {
  hot?: {
    accept(path?: string, cb?: () => void): void;
    dispose?(cb: () => void): void;
  };
}

/* TS 3.x needs the global var redeclared too */
declare var module: NodeModule;
